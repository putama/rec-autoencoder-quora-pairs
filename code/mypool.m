function [output_matrix] = mypool(input_matrix, pool_size, method)
    output_matrix = zeros(pool_size);
    
    [dim1, dim2] = size(input_matrix);
    
    indMI = repmat((1:dim1)',1,dim2);
    indMJ = repmat(1:dim2,dim1,1);
    
    while pool_size > dim1 %up-convert
        new_mat = zeros(2*dim1,dim2);
        new_ind = 2:2:2*dim1;
        new_mat(new_ind,:) = input_matrix;
        new_mat(new_ind-1,:) = input_matrix;
        input_matrix = new_mat;
        
        new_mat = zeros(2*dim1,dim2);
        new_ind = 2:2:2*dim1;
        new_mat(new_ind,:) = indMI;
        new_mat(new_ind-1,:) = indMI;
        indMI = new_mat;
        
        new_mat = zeros(2*dim1,dim2);
        new_ind = 2:2:2*dim1;
        new_mat(new_ind,:) = indMJ;
        new_mat(new_ind-1,:) = indMJ;
        indMJ = new_mat;
        
        dim1 = size(input_matrix,1);
    end
    
    while pool_size > dim2 %up-convert
        new_mat = zeros(dim1,2*dim2);
        new_ind = 2:2:2*dim2;
        new_mat(:,new_ind) = input_matrix;
        new_mat(:,new_ind-1) = input_matrix;
        input_matrix = new_mat;
        
        new_mat = zeros(dim1,2*dim2);
        new_ind = 2:2:2*dim2;
        new_mat(:,new_ind) = indMI;
        new_mat(:,new_ind-1) = indMI;
        indMI = new_mat;
        
        new_mat = zeros(dim1,2*dim2);
        new_ind = 2:2:2*dim2;
        new_mat(:,new_ind) = indMJ;
        new_mat(:,new_ind-1) = indMJ;
        indMJ = new_mat;
        
        dim2 = size(input_matrix,2);
    end
    
    quot1 = floor(dim1/pool_size);
    quot2 = floor(dim2/pool_size);
    rem1 = dim1 - quot1*pool_size;
    rem2 = dim2 - quot2*pool_size;
    
    vec1 = [0; cumsum(quot1*ones(pool_size,1) + [zeros(pool_size - rem1,1); ones(rem1,1)])];
    vec2 = [0; cumsum(quot2*ones(pool_size,1) + [zeros(pool_size - rem2,1); ones(rem2,1)])];
    
    
    pos = zeros(size(output_matrix));
    pos = cat(3,pos,pos);
    if method == 1
        func = @mean;
    elseif method == 2
        func = @min;
    end
    
    for i=1:pool_size
        for j=1:pool_size
            
            pooled = input_matrix(vec1(i)+1:vec1(i+1),vec2(j)+1:vec2(j+1));
            
            output_matrix(i,j) = func(pooled(:));
        end
    end
end

