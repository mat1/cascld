CREATE TABLE IF NOT EXISTS pcws_codes(
  account_id     INTEGER PRIMARY KEY,
  barcode_number INTEGER
);

CREATE OR REPLACE FUNCTION get_barcode_number(
  par_account_id int
) RETURNS int AS $$
  DECLARE
    loc_barcode_number int;
  BEGIN
	  SELECT barcode_number INTO loc_barcode_number FROM pcws_codes WHERE account_id = par_account_id;
	  IF NOT FOUND THEN
	    loc_barcode_number := 1;
	    INSERT INTO pcws_codes VALUES(par_account_id, loc_barcode_number);
	   else
	    loc_barcode_number := loc_barcode_number + 1;
	    UPDATE pcws_codes SET barcode_number = loc_barcode_number WHERE account_id = par_account_id;
	  END IF;
    RETURN loc_barcode_number;
  END;
$$ LANGUAGE plpgsql;