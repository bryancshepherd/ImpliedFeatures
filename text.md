Recently I was asked to provide a user profile for a specific type of software. In other words, to answer the question, "Who are 'X' software's primary users?" There are many different dimensions on which 'X' software's users could be profiled. For now, let's set that component aside and focus on how to analytically answer the question. Specifically, what data will we use? 

There are several potential data sources for that could be used, but they aren't necessarily easy to come by. If you are the company that produces X and you have good customer data, that's one way. If you have time and money to do a survey, that's another. But if you don't have customer data on users of X, or you don't have time or money, you need another solution. 

When a direct solution isn't available, it helps to think about ways to answer challenges indirectly. And that's when it gets fun. 

For now, let's restrict our goal to an understanding the average business user of X software. 

Almost by definition, we should expect there to be a correlation between the type of person job descriptions are looking for and the type of person they hire. Therefore, if a company is looking for a Python programmer who also has experience in electrical engineering, we can assume they will hire someone with that meets those requirements. Of course, at the individual level, there will be some exceptions, but in aggregate, individuals sought should roughly match individuals hired. 

Indeed.com is one of the largest job aggregators and therefore a good data source. The code in this repository submits searches and fetches job listings mentioning SPSS and Python on Indeed.com. There is also an example analysis that includes a simple word count analysis of the job titles and descriptions. The chart below shows the results for the job titles.

How often a term on the X-axis occurs in the list of job titles a search returns is indicated by the Y-axis. The statistical package used as the search term is color coded. E.g., the first term, “analyst”, was in ~14% of the job titles returned for a search of “SPSS” and ~2.5% of the job titles returned for a search of “Python”. This chart is restricted to the most common terms.

As you can see, job descriptions requiring or mentioning SPSS tend to include terms in the job title that are more general, social science-y, or marketing/business oriented. Job descriptions requiring or mentioning Python have more engineering and manufacturing focused job titles. 

The analysis of the job summaries highlights what software tends to be mentioned together. For example, SPSS and Stata are often mentioned together and Python and Minitab are often mentioned together, but there isn’t much overlap in those groups. However, R and SAS show up in job descriptions that include SPSS or Python. 

These are quick-and-dirty analyses, just to show the resulting data, but feel free to use the functions. 

Anyway, I found this interesting and might use it as background information in my presentation. If you have any thoughts or comments I’d love to hear them.

Extra stuff

-----------
We've already said we don't have enough time or data to field a survey, but if we did, we might do something like send a survey to every company that we know of that uses X software. Then, in some number of questions, we'd ask them to give us a picture of the types of people that use X software at their company. E.g., is it scientists, HR personnel, marketing, etc. 

I came across a couple of old articles by Bob Muenchen that looked at trends in how often statistical software packages were mentioned in job postings, based on Indeed.com data. This is good for gauging market share of a package, but it doesn’t give insight into who is using it, and for what. But it provided useful background and technical information.
