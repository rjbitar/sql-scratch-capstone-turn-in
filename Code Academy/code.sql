
1.1 https://gist.github.com/78d1e6c99c4658ecff63cb0e902b0135

1  SELECT COUNT(DISTINCT utm_campaign) AS 'Campaign Count' 
2  FROM page_visits; 
3  
 
4  SELECT COUNT(DISTINCT utm_source) AS 'Source Count' 
5  FROM page_visits; 
6  
 
7  SELECT DISTINCT utm_campaign AS Campaigns, 
8  	  utm_source AS Sources 
9  FROM page_visits; 


1.2 https://gist.github.com/b8ad37bdef48a96119cd6489bbf32fc8

1  SELECT DISTINCT page_name AS 'Page Names' 
2  FROM page_visits; 





2.1 https://gist.github.com/aaa1f361b95f27f3604c36fd9363520d


1  WITH first_touch AS( 
2      SELECT user_id, 
3             MIN(timestamp) AS first_touch_at 
4      FROM page_visits 
5      GROUP BY user_id), 
6      ft_attr AS ( 
7        SELECT ft.user_id, 
8               ft.first_touch_at, 
9               pv.utm_source, 
10               pv.utm_campaign 
11      FROM first_touch ft 
12      JOIN page_visits pv 
13        ON ft.user_id = pv.user_id 
14        AND ft.first_touch_at = pv.timestamp 
15      ) 
16      SELECT ft_attr.utm_source AS Source, 
17             ft_attr.utm_campaign AS Campaign, 
18             COUNT(*) AS COUNT 
19   FROM ft_attr 
20   GROUP BY 1, 2 
21   ORDER BY 3 DESC; 

 

2.2 https://gist.github.com/fdd4daedd79cc9ce808094e10b3ec999

1  WITH last_touch AS( 
2      SELECT user_id, 
3             MAX(timestamp) AS last_touch_at 
4      FROM page_visits 
5      GROUP BY user_id), 
6  ft_attr AS ( 
7      SELECT lt.user_id, 
8             lt.last_touch_at, 
9             pv.utm_source, 
10             pv.utm_campaign 
11      FROM last_touch lt 
12      JOIN page_visits pv 
13        ON lt.user_id = pv.user_id 
14        AND lt.last_touch_at = pv.timestamp 
15      ) 
16      SELECT ft_attr.utm_source AS Source, 
17             ft_attr.utm_campaign AS Campaign, 
18             COUNT(*) AS COUNT 
19   FROM ft_attr 
20   GROUP BY 1, 2 
21   ORDER BY 3 DESC; 

 

2.3 https://gist.github.com/codecademydev/19ba83aab28ff9ecb157e0ae2610a1d0

1  SELECT COUNT(DISTINCT user_id) AS 'Customers that Purchase' 
2  FROM page_visits 
3  WHERE page_name = '4 - purchase'; 




2.4 https://gist.github.com/codecademydev/4e4e31c3b7fd3ac102ffba8101e10f70

1  WITH last_touch AS ( 
2      SELECT user_id, 
3      MAX(timestamp) AS last_touch_at 
4      FROM page_visits 
5     WHERE page_name = '4 - purchase' 
6      GROUP BY user_id), 
7  ft_attr AS ( 
8    SELECT lt.user_id, 
9           lt.last_touch_at, 
10           pv.utm_source, 
11           pv.utm_campaign 
12    FROM last_touch lt 
13    Join page_visits pv 
14      ON lt.user_id = pv.user_id 
15      AND lt.last_touch_at = pv.timestamp) 
16  SELECT ft_attr.utm_source AS Source, 
17         ft_attr.utm_campaign AS Campaign, 
18         COUNT(*) AS COUNT 
19  FROM ft_attr 
20  GROUP BY 1, 2 
21  ORDER BY 3 DESC; 
