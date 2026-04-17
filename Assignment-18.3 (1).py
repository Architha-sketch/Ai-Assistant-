"""#TASK 1:Public Transport Route Fare API
import requests

def get_fare(source, destination):
    try:
        # Simulated API response (since real API not available)
        fake_api_response = {
            "A-B": 50,
            "B-C": 40,
            "A-C": 80
        }

        key = f"{source}-{destination}"

        if key in fake_api_response:
            return fake_api_response[key]
        else:
            raise ValueError("Invalid station names")

    except Exception:
        raise ValueError("Network error or API down")


def main():
    source = input("Enter the source station: ").strip()
    destination = input("Enter the destination station: ").strip()

    if not source or not destination:
        print("Invalid input")
        return

    try:
        fare = get_fare(source, destination)

        print("\n Transport Fare Details")
        print("---------------------------")
        print(f"Source      : {source}")
        print(f"Destination : {destination}")
        print(f"Fare        : ₹{fare}")
        print("---------------------------")

    except ValueError as e:
        print("", e)


if __name__ == "__main__":
    main()"""




"""#Task 2 :Currency Exchange Rates
import requests

def convert_currency(amount):
    url = "https://api.exchangerate-api.com/v4/latest/INR"

    try:
        response = requests.get(url, timeout=5)

        if response.status_code != 200:
            raise ValueError("⚠ API is unavailable")

        data = response.json()

        if "rates" not in data:
            raise ValueError("Invalid API response")

        rates = data["rates"]

        return {
            "USD": amount * rates["USD"],
            "EUR": amount * rates["EUR"],
            "GBP": amount * rates["GBP"]
        }

    except requests.exceptions.RequestException:
        raise ValueError("Network error or API down")


def main():
    try:
        amount = float(input("Enter amount in INR: "))

        if amount <= 0:
            print("Amount must be greater than 0")
            return

        result = convert_currency(amount)

        # ✅ Tabular Output
        print("\n💱 Currency Conversion Table")
        print("--------------------------------")
        print(f"{'Currency':<10}{'Amount':>10}")
        print("--------------------------------")
        print(f"{'USD':<10}{result['USD']:>10.2f}")
        print(f"{'EUR':<10}{result['EUR']:>10.2f}")
        print(f"{'GBP':<10}{result['GBP']:>10.2f}")
        print("--------------------------------")

    except ValueError:
        print("Invalid input. Please enter a number.")

    except Exception as e:
        print("Error:", e)


if __name__ == "__main__":
    main()"""



"""#TASK 3:GitHub Repository Info Fetcher
import requests

def get_repo_info(owner, repo):
    url = f"https://api.github.com/repos/{owner}/{repo}"

    try:
        response = requests.get(url, timeout=5)

        # Handle errors
        if response.status_code == 404:
            raise ValueError("Repository not found")

        if response.status_code == 403:
            raise ValueError("⚠ API rate limit exceeded. Try later")

        if response.status_code != 200:
            raise ValueError("⚠ API error occurred")

        data = response.json()

        return {
            "name": data.get("name", "N/A"),
            "description": data.get("description", "No description"),
            "stars": data.get("stargazers_count", 0),
            "forks": data.get("forks_count", 0),
            "issues": data.get("open_issues_count", 0)
        }

    except requests.exceptions.RequestException:
        raise ValueError("Network error or API unreachable")


def main():
    owner = input("Enter repository owner (username): ").strip()
    repo = input("Enter repository name: ").strip()

    # Input validation
    if not owner or not repo:
        print("Invalid input. Owner and repo cannot be empty")
        return

    try:
        info = get_repo_info(owner, repo)

        # Structured Output
        print("\n GitHub Repository Details")
        print("--------------------------------------")
        print(f"Name        : {info['name']}")
        print(f"Description : {info['description']}")
        print(f"Stars     : {info['stars']}")
        print(f"Forks     : {info['forks']}")
        print(f"Issues    : {info['issues']}")
        print("--------------------------------------")

    except ValueError as e:
        print(e)


if __name__ == "__main__":
    main()"""




"""#TASK4:Real-Time Application: News Headlines Aggregator
import requests
import time

API_KEY = "YOUR_API_KEY"   # Replace with your NewsAPI key

def get_news(category):
    url = "https://newsapi.org/v2/top-headlines"

    params = {
        "category": category,
        "apiKey": API_KEY,
        "country": "in"
    }

    for attempt in range(2):  # Retry mechanism
        try:
            response = requests.get(url, params=params, timeout=5)

            if response.status_code == 401:
                raise ValueError("Invalid or missing API key")

            if response.status_code != 200:
                raise ValueError("API request failed")

            data = response.json()

            if data.get("status") != "ok":
                raise ValueError("Invalid category or API error")

            articles = data.get("articles", [])

            if not articles:
                raise ValueError("No news found")

            return articles[:5]   # Top 5 headlines

        except requests.exceptions.RequestException:
            if attempt == 0:
                print("Retry... Please wait")
                time.sleep(2)
            else:
                raise ValueError("Network error or API unreachable")

    raise ValueError("Failed after retry")


def main():
    category = input("Enter category (sports/technology/health): ").lower().strip()

    # Validate category
    if category not in ["sports", "technology", "health"]:
        print("Invalid category")
        return

    try:
        articles = get_news(category)

        # Numbered List Output
        print(f"\nTop 5 {category.capitalize()} Headlines:\n")

        for i, article in enumerate(articles, 1):
            print(f"{i}. {article['title']}")

    except ValueError as e:
        print(e)


if __name__ == "__main__":
    main()"""





#TASK 5: COVID-19 Statistics API Integration
import requests
import time

def get_covid_data(country):
    url = f"https://disease.sh/v3/covid-19/countries/{country}"

    for attempt in range(2):   # Retry mechanism
        try:
            response = requests.get(url, timeout=5)

            # Invalid country
            if response.status_code == 404:
                raise ValueError("Invalid country name")

            # ⚠ Rate limit exceeded
            if response.status_code == 429:
                if attempt == 0:
                    print("Rate limit exceeded. Waiting and retrying...")
                    time.sleep(2)
                    continue
                else:
                    raise ValueError("⚠ API rate limit exceeded. Try later")

            # Other API errors
            if response.status_code != 200:
                raise ValueError("⚠ API error occurred")

            data = response.json()

            return {
                "cases": data.get("cases", 0),
                "deaths": data.get("deaths", 0),
                "recovered": data.get("recovered", 0),
                "active": data.get("active", 0)
            }

        except requests.exceptions.RequestException:
            raise ValueError(" Network or server error")

    raise ValueError(" Failed after retry")


def main():
    country = input("Enter country name: ").strip()

    # Input validation
    if not country:
        print("Country name cannot be empty")
        return

    try:
        stats = get_covid_data(country)

        # Structured Output
        print("\nI COVID-19 Statistics")
        print("--------------------------------")
        print(f"Country          : {country}")
        print(f"Total Cases      : {stats['cases']}")
        print(f"Total Deaths     : {stats['deaths']}")
        print(f"Recovered Cases  : {stats['recovered']}")
        print(f"Active Cases     : {stats['active']}")
        print("--------------------------------")

    except ValueError as e:
        print(e)


if __name__ == "__main__":
    main()