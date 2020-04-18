# Ocena modelu regresyjnego

#### Sposoby oceny jakości predykcji modelu regresji

Oznaczmy $x_i$ jako wektor zmiennych objaśniających, natomiast $y_i$ jako odpowiadającą mu wartość zmiennej zależnej. Oznaczmy przez $\hat{y} = f(x)$ predykcję modelu $f()$ odpowiadające $y_i$.

Niech $X=(x_1', \dots, x_n')$ oznacza macierz zmiennych objaśniających dla wszystkich $n$ obserwacji oraz $y=(y_1, \dots, y_n)'$ wektor wartości zmiennej objaśnianej.



* $MSE$ *(Mean Square Error)*

$$MSE(f, X, y) = \frac{1}{n}\sum_{i}^{n}(f(x_i)-y_i)^2 = \frac{1}{n}\sum_{i}^{n}r_i^2,$$
gdzie $r_i=f(x_i)-y_i$ oznacza resztę dla $i$-tej obserwacji.
Dla perfekcyjnego modelu, czyli takiego gdzie wszystkie predykcykcje są równe wartościom $y_i$, $MSE=0$.



* $RMSE$ *(Root Mean Square Error)*

$$RMSE(f, X, y) = \sqrt{MSE(f, X, y)}$$



* $R^2$ *(Coefficient of determination)*

$$R^2(f, X, y) = 1 - \frac{MSE(f, X, y)}{MSE(f_0, X, y)}$$
$f_0$ oznacza bazowy model. Dla klasycznej regresji liniowej oznacza to, że jako predykcję dla każdej obserwacji przyjmujemy średnią ze wszystkich wartości $Y$.



* $MAD$ *(Median Absolute Deviation)*

$$MAD(f, X, y) = median(|r_1|, \dots, |r_n|)$$
Miara $MAD$ jest bardziej odporna na outliery niż $MSE$.


* $MAE$ *(Mean Absolute Error)*

$$MAE(f, X, y) = \frac{1}{n}\sum_{i}^{n}|r_i|$$

* $MAPE$ *(Mean absolute percentage error)*

$$MAPE(f, X, y) = \frac{100\%}{n}\sum_{i}^{n}\Big|\frac{r_i}{y_i}\Big|$$


* $Testy \ statystyczne$

  - $t-test$
  
  Możemy ocenić czy średnia wartość reszt jest równa 0.
  
  - $Welch \ test$
  
  Możemy ocenić czy średnia wartość reszt w zbiorze treningowy jest równa średniej wartości reszt w zbiorze testowym.
  
  - $F-test$
  
  Prównanie wariancji reszt ze zbiory treningowego oraz reszt ze zbioru testowego. Aby wykorzystać F-test, rozkłady muszą być z rozkładu normalnego, sprawdzamy testem Shapiro-Wilka.
  
  - $Kolmogorov-Smirnov \ test$
  
  Test do oceny podobieństwa rozkładu prawdopodobieństwa reszt ze zbioru treningowego i testowego.
  
  
#### Inne pomysły

- *Średni błąd względny*

$$\frac{1}{n}\sum_{i}^{n}\frac{|y_i - \hat{y_i}|}{y_i}$$