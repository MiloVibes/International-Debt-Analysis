# International Debt Analysis - Expanded Project

This project is an expanded analysis of global debt, building upon the foundational work from the original project inspired by Naema Zamil. It incorporates additional datasets to provide a more comprehensive and temporal view of international and central government debt.

## Original Project Inspiration Source
* **Author:** Naema Zamil
* **GitHub Repo:** [Analyze-International-Debt-Statistics](https://github.com/naemazam/Analyze-International-Debt-Statistics/tree/main)
* **Original Dataset:** [Analyze International Debt Statistics Dataset](https://www.kaggle.com/datasets/salmaneunus/analyze-international-debt-statistics-dataset?select=international_debt.csv) (This dataset was the primary focus of the original SQL-based project.)

## Datasets Used in This Expanded Analysis
This expanded analysis primarily utilizes the following new datasets for a more in-depth look at central government debt trends over time:
1.  **Central Government Debt (% of GDP):** `central_government_debt.csv` ([Source: Global Debt Data](https://www.kaggle.com/datasets/sazidthe1/global-debt-data?select=central_government_debt.csv)). This dataset provides annual average central government debt as a percentage of GDP from 1950 to 2022.
2.  **World GDP Data:** `World GDP 1960-2022.csv` ([Source: GDP 1960-2022 Analysis Input](https://www.kaggle.com/code/annafabris/gdp-1960-2022-analysis/input)). This dataset provides GDP figures for various countries from 1960-2022.
3.  **World Population Data:** `world population from 1960 to 2023.csv` ([Source: Population World since 1960 to 2023](https://www.kaggle.com/datasets/fredericksalazar/population-world-since-1960-to-2021)). This dataset contains population data from 1960-2023.

*(The original `international_debt.csv` was analyzed using SQL in the inspirational project but is not the primary focus of the Python-based expanded analysis described here, which centers on the `central_government_debt.csv` and its relationship with GDP and population over time.)*

## Improvements Over Original Project

The original project provided a good starting point by performing SQL-based descriptive analytics on the `international_debt.csv` dataset, focusing on aspects like total debt, top indebted countries, and common debt indicators from a relatively static perspective.

This expanded analysis significantly enhances the original by:
1.  **Introducing a Temporal Dimension:** The primary dataset (`central_government_debt.csv`) includes annual data from 1950-2022, allowing for the analysis of debt trends over several decades.
2.  **Incorporating Multiple Data Sources:** Integrates central government debt data with historical GDP and population data. This enables a richer analysis, including the calculation of absolute debt from percentages and the potential for per capita metrics.
3.  **Focusing on Relative Debt Burden:** Shifts the primary analysis to debt as a percentage of GDP, offering a more standardized measure of a country's debt situation relative to its economic output.
4.  **Calculating Derived Metrics:** Instead of relying solely on provided debt figures for various indicators, this project calculates absolute central government debt values by combining debt-to-GDP percentages with actual GDP data.
5.  **Advanced Data Processing:** Implements more sophisticated data cleaning and preprocessing techniques using Python (Pandas), including:
    * Handling character encoding issues during data loading.
    * Reshaping data from wide to long format for time-series analysis.
    * Standardizing country names for accurate merging of datasets.
    * Implementing strategies for handling missing data (NaNs).
    * Aligning datasets to common year ranges.
6.  **Enhanced Visualizations and Analysis:** Utilizes Python libraries (`matplotlib`, `seaborn`) for more insightful visualizations, such as:
    * Histograms showing the distribution of debt percentages.
    * Line plots illustrating global and country-specific debt trends over time.
    * Bar charts for ranking countries by debt metrics.
    * Heatmaps to visualize data availability across countries and years.
7.  **Code-based Analysis:** Moves from SQL queries to a Python-based analysis (Jupyter Notebook), allowing for more complex data manipulation, statistical analysis, and custom visualizations.

## Key Approaches Used in This Expanded Analysis

* **Data Loading and Initial Exploration:**
    * Loaded three core CSV files (`central_government_debt.csv`, `World GDP 1960-2022.csv`, `world population from 1960 to 2023.csv`) into Pandas DataFrames.
    * Handled potential `UnicodeDecodeError` by attempting 'latin1' encoding when 'utf-8' failed.
    * Performed initial data inspection using `.head()`, `.info()`, and `.isnull().sum()` to understand structure, data types, and missing values.
* **Data Cleaning and Preprocessing:**
    * **Reshaping Data:** The `central_government_debt.csv` (initially in a wide format with years as columns) was transformed into a long format using `pd.melt()`. This created 'Year' and 'Debt_Percentage' columns, suitable for time-series analysis.
    * **Type Conversion:** Ensured 'Year' and 'Debt_Percentage' (and similar columns in other datasets) were converted to numeric types.
    * **Standardization:** Cleaned country names (stripping whitespace, title casing) to ensure consistency for merging.
    * **Missing Data Handling:** Addressed missing values by forward-filling GDP data and dropping rows with excessive missing data in the debt dataset.
    * **Data Alignment:** Identified common year ranges across the datasets (primarily 1960-2022) and filtered them accordingly to ensure consistency in merged analyses.
* **Feature Engineering:**
    * **Absolute Debt Calculation:** Merged the long-format debt percentage data with the GDP data (after its own cleaning and reshaping) on 'country_name' and 'year'. Calculated absolute debt amount using the formula: `debt_amount = (GDP * debt_pct_gdp) / 100`.
* **Analytical Techniques:**
    * **Descriptive Statistics:** Calculated means, medians, and distributions for debt percentages.
    * **Trend Analysis:** Grouped data by 'Year' to analyze global mean and median debt percentage trends. Plotted time-series for selected countries.
    * **Ranking:** Identified and visualized top/bottom countries based on debt percentages in the latest available year.
* **Visualization:**
    * Employed `matplotlib` and `seaborn` for creating various plots.
    * Used custom functions to format percentage and currency values on axes and in tables for better readability.
    * Generated histograms, bar plots, line plots, and a data availability heatmap.

## Challenges Faced

* **Data Loading & Encoding:** Encountered `UnicodeDecodeError` with some CSV files, necessitating the use of alternative encodings like 'latin1'.
* **Data Consistency Across Sources:**
    * Standardizing country names was essential for successful merging of the three different datasets.
    * Aligning time periods (years) across datasets required careful filtering to ensure comparable analysis.
* **Missing Data:** All datasets had missing values for various countries and years. Strategies like forward-filling (for GDP) and dropping rows/columns with high percentages of missing data were employed, which could impact the completeness of the analysis for certain entities or periods.
* **Data Reshaping Complexity:** Converting the debt data from a wide to a long format, especially with many year columns, required robust logic to correctly identify and handle these columns.
* **Indicator Variability:** The debt dataset contained various indicator names. The analysis focused on "Annual average of central government debt (Percent of GDP)", but identifying this consistently or programmatically selecting the most relevant indicator can be a challenge if naming conventions differ.
* **Data Sparsity:** As visualized by the data availability heatmap, the central government debt data was sparse for earlier years and for certain countries, potentially limiting the scope of long-term trend analysis for some regions.

## Conclusion of Expanded Analysis

The expanded analysis provided a deeper understanding of central government debt trends by looking at debt-to-GDP percentages over time and across many countries. Key findings included:
* A snapshot of global debt percentages for the most recent year (2022), highlighting the average and median debt burdens.
* Identification of countries with the highest and lowest debt-to-GDP ratios, offering insights into varying fiscal positions.
* Visualization of global mean and median debt percentage trends, showing the evolution of debt burdens over decades.
* Comparative trend analysis for selected major economies and top/bottom indebted nations.
* The calculation of absolute debt values (by combining debt % of GDP with nominal GDP) and debt per capita (by further combining with population data) provided a multi-faceted view of debt, showing how debt burdens relate to economic output and population size.
* The analysis revealed significant variations in debt levels based on income groups and how debt accumulation has evolved across different decades.

By transforming debt percentages into absolute and per-capita figures using GDP and population data, the project underscored the importance of contextualizing debt within economic capacity and population size. While data limitations were acknowledged, the methodology demonstrated a robust approach to analyzing government debt, and the identified patterns serve as valuable insights for understanding public finance and the global economic landscape.