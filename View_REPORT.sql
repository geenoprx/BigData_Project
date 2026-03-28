-- Report: total cost grouped by cost type
SELECT
    ct.Name AS CostTypeName,
    SUM(cd.FeeAmount * cd.Quantity) AS TotalCost
FROM CostDetail cd
JOIN ItemCost ic ON cd.ItemCostID = ic.ItemCostID
JOIN CostType ct ON ic.CostTypeID = ct.CostTypeID
GROUP BY ct.Name
ORDER BY TotalCost DESC;

-- Report: cancelled bookings with tour name and payment status
SELECT
    b.BookingID,
    t.Name AS TourName,
    b.BookingStatus,
    b.PaymentStatus
FROM Booking b
JOIN BookingDetail bd ON b.BookingID = bd.BookingID
JOIN Tour t ON bd.TourID = t.TourID
WHERE b.BookingStatus = 'CANCELLED'
GROUP BY b.BookingID, t.Name, b.BookingStatus, b.PaymentStatus;
