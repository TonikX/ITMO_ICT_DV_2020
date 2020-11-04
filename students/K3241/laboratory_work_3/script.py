import pandas as pd

dataset = pd.read_csv("master.csv", delimiter=';')

chart1 = dataset.groupby('sex')['suicides_no'].sum()
chart1.to_csv("chart1.csv", sep=';')
chart2 = dataset.groupby('country')['suicides_no'].sum()
chart2.to_csv("chart2.csv", sep=';')
chart3 = dataset.groupby('generation')['suicides_no'].sum()
chart3.to_csv("chart3.csv", sep=';')
chart4 = dataset.groupby('year')['suicides_no'].sum()
chart4.to_csv("chart4.csv", sep=';')
