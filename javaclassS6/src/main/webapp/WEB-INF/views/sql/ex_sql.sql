CREATE TABLE Trails (
    trail_id INT PRIMARY KEY AUTO_INCREMENT, /* 산책로 고유번호 */
    name VARCHAR(255) NOT NULL, /* 산책로 이름 */
    location VARCHAR(255) NOT NULL, /* 산책로 위치 */
    difficulty VARCHAR(10) NOT NULL, /* 산책로 난이도 ('Easy', 'Moderate', 'Hard') */
    length_km DOUBLE NOT NULL, /* 산책로 길이 */
    description TEXT, /* 산책로 설명 */
    rating DOUBLE DEFAULT 0, /* 산책로 평점 */
    num_reviews INT DEFAULT 0, /* 리뷰 수 */
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, /* 생성일 */
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP /* 업데이트일 */
);

DELIMITER //
CREATE TRIGGER before_trails_update
BEFORE UPDATE ON Trails
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END;
//
DELIMITER ;

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT, /* 리뷰 고유번호 */
    trail_id INT, /* 산책로 고유번호 */
    user_id INT, /* 사용자 고유번호 */
    rating DECIMAL(3,2) NOT NULL CHECK (rating >= 0 AND rating <= 5), /* 리뷰 평점 */
    comment TEXT, /* 리뷰 내용 */
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, /* 작성일 */
    FOREIGN KEY (trail_id) REFERENCES Trails(trail_id) ON DELETE CASCADE, /* 산책로 외래키 */
    FOREIGN KEY (user_id) REFERENCES member(idx) ON DELETE CASCADE /* 사용자 외래키 */
);


CREATE TABLE User_Preferences (
    preference_id INT PRIMARY KEY AUTO_INCREMENT, /* 선호도 고유번호 */
    user_id INT, /* 사용자 고유번호 */
    preferred_location VARCHAR(255), /* 선호 위치 */
    preferred_difficulty VARCHAR(10), /* 선호 난이도 ('Easy', 'Moderate', 'Hard') */
    min_length_km DOUBLE, /* 최소 선호 길이 */
    max_length_km DOUBLE, /* 최대 선호 길이 */
    FOREIGN KEY (user_id) REFERENCES member(idx) ON DELETE CASCADE /* 사용자 외래키 */
);

SELECT * FROM Trails
ORDER BY RAND()
LIMIT 1;
