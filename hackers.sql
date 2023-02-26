SELECT
    DATE(submission_date) AS submission_date,
    COUNT(DISTINCT hacker_id) AS num_unique_hackers,
    (SELECT hacker_id
     FROM submissions
     WHERE DATE(submission_date) = submission_date
     GROUP BY hacker_id
     ORDER BY COUNT(*) DESC, hacker_id ASC
     LIMIT 1) AS hacker_id,
    (SELECT hacker_id
     FROM submissions
     WHERE DATE(submission_date) = submission_date
     AND hacker_id = (SELECT hacker_id
                      FROM submissions
                      WHERE DATE(submission_date) = submission_date
                      GROUP BY hacker_id
                      ORDER BY COUNT(*) DESC, hacker_id ASC
                      LIMIT 1)
     LIMIT 1) AS hacker_id
FROM
    submissions
WHERE
    DATE(submission_date) BETWEEN '2016-03-01' AND '2016-03-15'
GROUP BY
    submission_date
ORDER BY
    submission_date;
