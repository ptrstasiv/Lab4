#include <iostream>
#include <cmath>

constexpr int MaxIterations = 1024;

double Eps = 1e-5;

double GetFunctionRes(const double x)
{
	return 3 * x - 4 * std::log(x) - 5;
}

double GetFunctionDerivative(const double x)
{
	const double d = Eps / 1000.0;
	return (GetFunctionRes(x + d) - GetFunctionRes(x)) / d;
}

double GetFunctionDerivative2(const double x)
{
	const double d = Eps / 1000.0;
	return (GetFunctionDerivative(x + d) - GetFunctionDerivative(x)) / d;
}

int main()
{
	double a = 0.0;
	double b = 0.0;

	while (1)
	{
		std::cout << "\nEnter interval: ";
		std::cin >> a >> b;

		std::cout << "\nEnter result tolerance: ";
		std::cin >> Eps;


		double x = a;

		if (GetFunctionRes(x) * GetFunctionDerivative2(x) < 0.0)
		{
			x = b;

			if (GetFunctionRes(x) * GetFunctionDerivative2(x) < 0.0)
				std::cout << "\nFor the specified interval result is not guaranteed!";
		}


		int iterations = 0;

		while(1)
		{
			if (iterations > MaxIterations)
				break;

			double d = GetFunctionRes(x) / GetFunctionDerivative(x);
			x = x - d;

			if (std::abs(d) <= Eps)
				break;

			++iterations;
		}

		std::cout << "\nApproximate root is: " << x << " found in: " << iterations << " iterations\n\n";
	}

	return(0);
}