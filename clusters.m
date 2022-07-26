%pasamos el numeros de centroides a una variable K
K = 3;

%son 4 columnas por cada varName que tenemos 3 centroides ya que tenemos un total de 3 clases
centroides = zeros(K,4);



irisSize = size(iris);

m = irisSize(1,1);

repetidos = ones(m,1)
%elimina todos los valores que tienen en valor 1
for e=1:m-1
    for d=e+1:m
        if (iris(e,1) == iris(d,1))
            if(iris(e,2) == iris(d,2))
                if(iris(e,3) == iris(d,3))
                    if(iris(e,4) == iris(d,4))
                        repetidos(e,1) = 0;
                    end
                end
            end
        end
    end
end

repetidosMap = (repetidos==1)

irisAct = iris(repetidosMap,:);

%obtenemos el total de las muestras que tenemos
irisSize = size(irisAct(:,1));

%Generamos numeros randoms para cada y uno de los centroides

for i=1:K
    for j=1:4
        rand_range = [(min(irisAct(:,j))-1), (max(irisAct(:,j)))];
        rand_range = [ceil(rand_range(1)) floor(rand_range(2))];
        randRange = sort(rand_range);
        centroides(i,j) = (randi(randRange));
    end
end



mAct= irisSize(1,1);


Resultados = zeros(mAct,1);

c_ent = zeros(mAct,1);
finalizado(1,1) = 0;
while (finalizado(1,1) == 0)
    for i=1:K
        for a=1:mAct
            Resultados(a,b) = (((irisAct(a,1)-centroides(b,1))^2)+((irisAct(a,2)-centroides(b,2))^2)+ ((irisAct(a,3)-centroides(b,3))^2)+((irisAct(a,4)-centroides(b,4))^2));
        end;
    end;
    
    for f=1:mAct
        if Resultados(f,1)<Resultados(f,2)&&Resultados(f,1)<Resultados(f,3)
        c(f,1) = 1;
        elseif Resultados(f,2)<Resultados(f,1)&&Resultados(f,2)<Resultados(f,3)
        c(f,1) = 2;
        elseif Resultados(f,3)<Resultados(f,1)&&Resultados(f,3)<Resultados(f,2)
        c(f,1) = 3;
        end;
    end;
    c1map = (c(:,1)==1);
    c1 = irisAct(c1map,:);
    c1Size = size(c1(:,1));
    
    
    c2map = (c(:,1)==2);
    c2 = irisAct(c2map,:);
    c2Size = size(c2(:,1));
    
    
    c3map = (c(:,1)==3);
    c3 = irisAct(c3map,:);
    c3Size = size(c3(:,1));
    
    for g=1:4

        centroides(1,g) = ((sum(c1(:,g)))/c1Size(1,1))
   

        centroides(2,g) = ((sum(c2(:,g)))/c2Size(1,1))
   

        centroides(3,g) = ((sum(c3(:,g)))/c3Size(1,1))
    end;
    
    if (c == c_ent)
       finalizado(1,1) = 1; 
    else
       c_ent = c;
       c(:,1) = 0;
    end;
    
end;



    
    

