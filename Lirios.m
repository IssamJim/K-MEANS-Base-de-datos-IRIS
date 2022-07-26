filename='iris.csv';
Iris=readtable(filename);
iris = Iris{:,1:4}; %quitamos los indices de la base de datos


%{
Med=mean(iris(:,1)); %Obtenemos la media de los registros de los atributo
Desv=std(iris(:,1)); %Obtenemos la desviacion estandar de los registros
plot(iris(:,1), '*'); %Graficamos los registros del atributo 
title('Lirios')
ylabel('Sepal Length in cm') 
%}
                            %C E N T R O I D E S   I N I C I A L E S 
                            
k = 3; %Numero de centroides                  
                           
%{
Centroides = zeros(k,4); %Tabla de Centroides 

for i=1:k %Iteramos por los registros renglon por renglon
    for j=1:4 %Por cada renglon iteramos columna por columna
        
        Max = int16(max(iris(:,j))); %Numero maximo
        Min = int16(min(iris(:,j))); %Numero minimo

        Random = randi([Min,Max],1); %un solo valor random entre el minimo y el maximo 

        Centroides(i,j) = Random; %Asignamos el valor a la casilla de centroide correspondiente
        
    end
end

                            
T = size(iris,1);  %Tama;o total de la matriz                 
Distancias =  zeros(T,k); %Iniciamos la matriz para sumar las distancias de los atributos con los centroides
Clusters = zeros(T,1); %Iniciamos la matriz para comparar las distancias y asignarlas a su cluster
Clusters1 = zeros(T,1);%para coomparar los clusters 
Contador = 0; %para contar cuantas vueltas dio el while para resolver el problema
finalizado(1,1) = 0; %Para finalizar el while

%Con este bucle calculamos las distancias de cada atributo con cada centroide y le asignamos el centroide mas sercano
while (finalizado(1,1) == 0)
    for b=1:k
        for a=1:T
            %En Distancias guardamos las distancias de las muestras con los centroides
            Distancias(a,b) = (((iris(a,1)-Centroides(b,1))^2)+((iris(a,2)-Centroides(b,2))^2)+((iris(a,3)-Centroides(b,3))^2)+((iris(a,4)-Centroides(b,4))^2));
            %Con estos if asignamos el centroide mas sercano a cada muestra para formar los clusters
            if Distancias(a,1)<Distancias(a,2)&&Distancias(a,1)<Distancias(a,3)
            Clusters1(a,1) = 1;
            elseif Distancias(a,2)<Distancias(a,1)&&Distancias(a,2)<Distancias(a,3)
            Clusters1(a,1) = 2;
            elseif Distancias(a,3)<Distancias(a,1)&&Distancias(a,3)<Distancias(a,2)
            Clusters1(a,1) = 3;
            end;
        end;
    end;
    %Reasignamos los Centroides con la media de cada atributo
    c1map = (Clusters1==1);
    c1 = iris(c1map,:);
    Centroides(1,:) = mean(c1);

    c2map = (Clusters1==2);
    c2 = iris(c2map,:);
    Centroides(2,:) = mean(c2);

    c3map = (Clusters1==3);
    c3 = iris(c3map,:);
    Centroides(3,:) = mean(c3);

    if (Clusters1 == Clusters)
        finalizado(1,1) = 1; 
    else
        Contador = Contador+1;
        Clusters = Clusters1;
        Clusters1(:,1) = 0;
    end;
end;

    
grosor = 6;
figure(1)
hold on
plot(c1(:,3),c1(:,4),'*', 'color', 'blue', 'MarkerFaceColor', 'blue', 'MarkerSize', grosor);
plot(c2(:,3),c2(:,4),'*', 'color', 'red', 'MarkerFaceColor', 'red', 'MarkerSize', grosor);
plot(c3(:,3),c3(:,4),'*', 'color', 'magenta', 'MarkerFaceColor', 'magenta', 'MarkerSize', grosor);
plot(Centroides(:,3),Centroides(:,4),'*', 'color', 'green', 'MarkerFaceColor', 'green', 'MarkerSize', 6);
hold off
%}
iris(1:50,5)= 2; %Agregamos el numero del cluster correspondiente de la clase en la base de datos
Setosa = iris(1:50,:); %Guardamos solo la primera clase 
TPositive = sum(iris(1:50,5) == Clusters(1:50)); %True positive para la primera clase
FalseNegative1 = size(Setosa,1)-TPositive; %False Negative para la primer clase


iris(51:100,5)= 3; %Agregamos el numero 3 que es el cluster correspondiente
Versicolor = iris(51:100,:); %Separamos la segunda clase
TPositive2 = sum(iris(51:100,5)== Clusters(51:100));%Verdaderos positivos para esta clase
FalseNegative2 = size(Versicolor,1)-TPositive2; %Falsos negativos para esta clase


iris(101:150,5)= 1;
Virginica = iris(101:150,:);
TPositive3 = sum(iris(101:150,5) == Clusters(101:150));
FalseNegative3 = size(Virginica,1)-TPositive3;



%Metricas para la primer clase
PorcentajeSetosa = TPositive/size(Setosa,1); %Porcentaje de acierto para la primera clase.
Precision1= TPositive/TPositive + (FalseNegative2+FalseNegative3); %Los falsos negativos de las otras clases son los FalsePositive para esta clase
Recall1= TPositive/TPositive+FalseNegative1;
FScore1= 2*Precision1 * Recall1 / (Precision1 + Recall1);

%Metricas para la segunda clase
PorcentajeVersicolor = TPositive2/size(Versicolor,1); %Porcentaje de acierto para esta clase
Precision2= TPositive2/TPositive2 + (FalseNegative3); %Los falsos negativos de las otras clases son los falsos positivos de esta en este caso solo una
Recall2= TPositive2/TPositive2+FalseNegative2;
FScore2= 2*Precision2 * Recall2 / (Precision2 + Recall2);

%Metricas para la tercera clase
PorcentajeVirginica = TPositive3/size(Virginica,1);
Precision3= TPositive3/TPositive3 + (FalseNegative2); %Los falsos negativos de las otras clases son los falsos positivos de esta en este caso solo una
Recall3= TPositive3/TPositive3+FalseNegative3;
FScore3= 2*Precision3 * Recall3 / (Precision3 + Recall3);

