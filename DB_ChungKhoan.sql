USE [DB_ChungKhoan]
GO
/****** Object:  Table [dbo].[BANGGIATRUCTUYEN]    Script Date: 4/28/2022 10:30:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BANGGIATRUCTUYEN](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MACP] [nchar](7) NOT NULL,
	[GIAMUA3] [float] NULL,
	[LUONGMUA3] [int] NULL,
	[GIAMUA2] [float] NULL,
	[LUONGMUA2] [int] NULL,
	[GIAMUA1] [float] NULL,
	[LUONGMUA1] [int] NULL,
	[GIABAN3] [float] NULL,
	[LUONGBAN3] [int] NULL,
	[GIABAN2] [float] NULL,
	[LUONGBAN2] [int] NULL,
	[GIABAN1] [float] NULL,
	[LUONGBAN1] [int] NULL,
	[GIAKHOP] [float] NULL,
	[LUONGKHOP] [int] NULL,
	[TONGSO] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[MACP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LENHDAT]    Script Date: 4/28/2022 10:30:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LENHDAT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MACP] [nchar](7) NOT NULL,
	[NGAYDAT] [datetime] NOT NULL,
	[LOAIGD] [nchar](1) NOT NULL,
	[LOAILENH] [nchar](10) NOT NULL,
	[SOLUONG] [int] NOT NULL,
	[GIADAT] [float] NOT NULL,
	[TRANGTHAILENH] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LENHKHOP]    Script Date: 4/28/2022 10:30:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LENHKHOP](
	[IDKHOP] [int] IDENTITY(1,1) NOT NULL,
	[NGAYKHOP] [datetime] NOT NULL,
	[SOLUONGKHOP] [int] NOT NULL,
	[GIAKHOP] [float] NOT NULL,
	[IDLENHDAT] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDKHOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BANGGIATRUCTUYEN] ADD  CONSTRAINT [df_GiaMua3]  DEFAULT ((0)) FOR [GIAMUA3]
GO
ALTER TABLE [dbo].[BANGGIATRUCTUYEN] ADD  CONSTRAINT [df_LUONGMUA3]  DEFAULT ((0)) FOR [LUONGMUA3]
GO
ALTER TABLE [dbo].[BANGGIATRUCTUYEN] ADD  CONSTRAINT [df_GiaMua2]  DEFAULT ((0)) FOR [GIAMUA2]
GO
ALTER TABLE [dbo].[BANGGIATRUCTUYEN] ADD  CONSTRAINT [df_LUONGMUA2]  DEFAULT ((0)) FOR [LUONGMUA2]
GO
ALTER TABLE [dbo].[BANGGIATRUCTUYEN] ADD  CONSTRAINT [df_GiaMua1]  DEFAULT ((0)) FOR [GIAMUA1]
GO
ALTER TABLE [dbo].[BANGGIATRUCTUYEN] ADD  CONSTRAINT [df_LUONGMUA1]  DEFAULT ((0)) FOR [LUONGMUA1]
GO
ALTER TABLE [dbo].[BANGGIATRUCTUYEN] ADD  CONSTRAINT [df_GiaBAN3]  DEFAULT ((0)) FOR [GIABAN3]
GO
ALTER TABLE [dbo].[BANGGIATRUCTUYEN] ADD  CONSTRAINT [df_LUONGBAN3]  DEFAULT ((0)) FOR [LUONGBAN3]
GO
ALTER TABLE [dbo].[BANGGIATRUCTUYEN] ADD  CONSTRAINT [df_GiaBAN2]  DEFAULT ((0)) FOR [GIABAN2]
GO
ALTER TABLE [dbo].[BANGGIATRUCTUYEN] ADD  CONSTRAINT [df_LUONGBAN2]  DEFAULT ((0)) FOR [LUONGBAN2]
GO
ALTER TABLE [dbo].[BANGGIATRUCTUYEN] ADD  CONSTRAINT [df_GiaBAN1]  DEFAULT ((0)) FOR [GIABAN1]
GO
ALTER TABLE [dbo].[BANGGIATRUCTUYEN] ADD  CONSTRAINT [df_LUONGBAN1]  DEFAULT ((0)) FOR [LUONGBAN1]
GO
ALTER TABLE [dbo].[BANGGIATRUCTUYEN] ADD  CONSTRAINT [df_GIAKHOP]  DEFAULT ((0)) FOR [GIAKHOP]
GO
ALTER TABLE [dbo].[BANGGIATRUCTUYEN] ADD  CONSTRAINT [df_LUONGKHOP]  DEFAULT ((0)) FOR [LUONGKHOP]
GO
ALTER TABLE [dbo].[BANGGIATRUCTUYEN] ADD  CONSTRAINT [df_TONGSO]  DEFAULT ((0)) FOR [TONGSO]
GO
ALTER TABLE [dbo].[LENHDAT] ADD  DEFAULT (getdate()) FOR [NGAYDAT]
GO
ALTER TABLE [dbo].[LENHDAT] ADD  DEFAULT (N'Chờ khớp') FOR [TRANGTHAILENH]
GO
ALTER TABLE [dbo].[LENHKHOP] ADD  DEFAULT (getdate()) FOR [NGAYKHOP]
GO
ALTER TABLE [dbo].[LENHKHOP]  WITH CHECK ADD FOREIGN KEY([IDLENHDAT])
REFERENCES [dbo].[LENHDAT] ([ID])
GO
ALTER TABLE [dbo].[LENHDAT]  WITH CHECK ADD CHECK  (([LOAIGD]='M' OR [LOAIGD]='B'))
GO
ALTER TABLE [dbo].[LENHDAT]  WITH CHECK ADD CHECK  (([LOAILENH]='LO'))
GO
ALTER TABLE [dbo].[LENHDAT]  WITH CHECK ADD CHECK  (([TRANGTHAILENH]=N'Chờ khớp' OR [TRANGTHAILENH]=N'Khớp lệnh 1 phần' OR [TRANGTHAILENH]=N'Khớp hết' OR [TRANGTHAILENH]=N'Đã hủy' OR [TRANGTHAILENH]=N'Chưa khớp'))
GO
/****** Object:  StoredProcedure [dbo].[CursorLoaiGD]    Script Date: 4/28/2022 10:30:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CursorLoaiGD]
  @OutCrsr CURSOR VARYING OUTPUT, 
  @macp VARCHAR(7), @Ngay datetime,  @LoaiGD NCHAR(1) , @GiaDat float
AS
--Lệnh mua: Khớp với lệnh bán: Giá lệnh bán phải <= giá lệnh mua và giá bán nhỏ nhất thì khớp trước => Tìm các lệnh bán tm: Cùng MCP/ Cùng time => sort tăng dần theo giá và tăng dần theo theo thời gian. => đặt vào cursor => update 
-- Lệnh bán: Khớp với lệnh mua: Giá  lệnh mua >= giá lệnh bán và giá mua lớn nhất khớp trước => Tìm các lệnh mua tm: Cùng MCP/ Cùng time =>sort giảm dần theo giá và tăng dần theo thời gian => đặt vào cursor => update

IF (@LoaiGD='B') 
  SET @OutCrsr=CURSOR KEYSET FOR 
  SELECT NGAYDAT, SOLUONG, GIADAT FROM LENHDAT 
  WHERE MACP=@macp 
    AND CAST(NGAYDAT as date) = CAST(@Ngay as date)
    AND LOAIGD='M' AND SOLUONG >0  AND GIADAT >= @GiaDat
    ORDER BY GIADAT DESC, NGAYDAT 
ELSE
  SET @OutCrsr=CURSOR KEYSET FOR 
  SELECT NGAYDAT, SOLUONG, GIADAT FROM LENHDAT 
  WHERE MACP=@macp 
    AND CAST(NGAYDAT as date) = CAST(@Ngay as date)
    AND LOAIGD='B' AND SOLUONG > 0  AND GIADAT <= @GiaDat
    ORDER BY GIADAT, NGAYDAT 
OPEN @OutCrsr
GO
/****** Object:  StoredProcedure [dbo].[SP_KHOPLENH_LO]    Script Date: 4/28/2022 10:30:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_KHOPLENH_LO]
 @IDLenhMB int,  @macp VARCHAR(7), @Ngay datetime,  @LoaiGD NCHAR(1) , 
 @soluongMB INT, @giadatMB FLOAT 
AS
-- khaibao bien
DECLARE @CrsrVar CURSOR , @ngaydat datetime, @soluong INT, @giadat FLOAT, @IDLenhDat int, @soluongkhop INT, @giakhop FLOAT, @SLBanDau int = @SoluongMb
-- lay cursor cac giao dich khop lenh
EXEC CursorLoaiGD  @CrsrVar OUTPUT, @macp, @Ngay, @LoaiGD, @giadatMB
 -- 
FETCH NEXT FROM @CrsrVar  INTO  @ngaydat , @soluong , @giadat 
WHILE (@@FETCH_STATUS = 0 AND @soluongMB > 0)
BEGIN
 -- SELECT NGAYDAT = @ngaydat , SOLUONG = @soluong , GIADAT = @giadat 
 --IF  (@LoaiGD='B' )  -- TH LENH GUI VAO LA LENH BAN
   BEGIN
		 IF @soluongMB >= @soluong 
			 BEGIN
			   SET @soluongkhop = @soluong
			   SET @giakhop = @giadat
			   SET @soluongMB = @soluongMB - @soluong
			   UPDATE dbo.LENHDAT  
				 SET SOLUONG = 0,
				 TRANGTHAILENH = N'Khớp hết'
				-- @IDLenhDat = ID
				 WHERE CURRENT OF @CrsrVar
			 END
		ELSE
			 BEGIN
			   SET @soluongkhop = @soluongMB
			   SET @giakhop = @giadat
			   UPDATE dbo.LENHDAT  
				 SET SOLUONG = SOLUONG - @soluongMB ,
				 TRANGTHAILENH = N'Khớp lệnh 1 phần'
	--			 @IDLenhDat = ID
				 WHERE CURRENT OF @CrsrVar
			   SET @soluongMB = 0
			 END

	--	 SELECT  NGAYDAT = @ngaydat, SOLUONGKHOP = @soluongkhop, GIAKHOP = @giakhop , IDLENHDAT = @IDLenhDat
		 -- Cập nhật table LENHKHOP
		 INSERT INTO LENHKHOP 
		 VALUES ( @ngaydat, @soluongkhop, @giakhop , @IDLenhMB)
		 
    END

	FETCH NEXT FROM @CrsrVar  INTO  @ngaydat , @soluong , @giadat 
END

-- uodate trang thai lenhdatmuaban
IF @soluongMB = 0
	BEGIN
		UPDATE LENHDAT 
			SET SOLUONG = @soluongMB, TRANGTHAILENH = N'Khớp hết'
			WHERE ID = @IDLenhMB
	END
else if @soluongMB = @SLBanDau
	goto THOAT
else
	BEGIN
		UPDATE LENHDAT 
			SET SOLUONG = @soluongMB, TRANGTHAILENH = N'Khớp lệnh 1 phần'
			WHERE ID = @IDLenhMB
	END
	
THOAT:
CLOSE @CrsrVar
DEALLOCATE @CrsrVar

GO

-----------    TRIGGER AFTER INSERT dbo.LENHDAT

-- USE [DB_ChungKhoan]
GO
/****** Object:  Trigger [dbo].[TR_AfterInsert]    Script Date: 4/28/2022 10:31:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER  [dbo].[TR_AfterInsert]
   ON  [dbo].[LENHDAT]  AFTER  INSERT
AS 
 DECLARE @IDLenhMB int,  @macp VARCHAR(7), @Ngay datetime,  @LoaiGD NCHAR(1) , @soluongMB INT, @giadatMB FLOAT
 DECLARE @GiaMua1 float, @LuongMua1 int, @GiaMua2 float, @LuongMua2 int, @GiaMua3 float, @LuongMua3 int,
		@GiaBan1 float, @LuongBan1 int,@GiaBan2 float, @LuongBan2 int, @GiaBan3 float, @LuongBan3 int

BEGIN
   SELECT @IDLenhMB = ID, @macp = MACP, @Ngay = NGAYDAT, @LoaiGD = LOAIGD, @soluongMB = SOLUONG, @giadatMB = GIADAT FROM inserted
   -- CAP NHAT TABLE BANGGIATRUCTUYEN VE TOP 3 GIAMUA // GIA BAN
   -- NEU TRONG BANG GIA TRUC TUYEN CHUA CO LENHDAT NAO 
   IF NOT EXISTS (SELECT ID FROM BANGGIATRUCTUYEN WHERE MACP = @macp)
	   BEGIN
		 IF @LoaiGD = 'M'
			BEGIN
				INSERT INTO BANGGIATRUCTUYEN (MACP,GIAMUA1,LUONGMUA1)
				VALUES (@macp, @giadatMB,@soluongMB)
			END
		 ELSE
			BEGIN
				INSERT INTO BANGGIATRUCTUYEN (MACP,GIABAN1,LUONGBAN1)
				VALUES (@macp, @giadatMB,@soluongMB)
			END
	    END
   ELSE -- THAY DOI LAI BANGGIATRUCTUYEN CUA MACP NAY VE GIA VA SOLUONG TOP3 MUA/BAN
		BEGIN
			SELECT @giamua3 = GIAMUA3, @LuongMua3 = LUONGMUA3, @giamua2 = GIAMUA2, @LuongMua2 = LUONGMUA2, @giamua1 = GIAMUA1, @LuongMua1 = LUONGMUA1,
			@GiaBan3 = GIABAN3, @LuongBan3 = LUONGBAN3, @GiaBan2 = GIABAN2, @LuongBan2 = LUONGBAN2, @GiaBan1 = GIABAN1, @LuongBan1 = LUONGBAN1 
			FROM BANGGIATRUCTUYEN;
			IF @LoaiGD = 'M' -- TH CAP NHAT BANG GIA TRUC TUYEN CHO LENH MUA
				BEGIN
					IF @giadatMB > @GiaMua1
							UPDATE BANGGIATRUCTUYEN
							SET GIAMUA1 = @giadatMB, LUONGMUA1 = @soluongMB, GIAMUA2 = @GiaMua1, LUONGMUA2 = @LuongMua1,  GIAMUA3 = @GiaMua2, LUONGMUA3 = @LuongMua2
							WHERE MACP = @macp
					ELSE IF @giadatMB = @GiaMua1
							UPDATE BANGGIATRUCTUYEN
							SET LUONGMUA1 = @LuongMua1 +  @soluongMB
							WHERE MACP = @macp
					ELSE IF @giadatMB > @GiaMua2
							UPDATE BANGGIATRUCTUYEN
							SET GIAMUA2 = @giadatMB, LUONGMUA2 = @soluongMB, GIAMUA3 = @GiaMua2, LUONGMUA3 = @LuongMua2
							WHERE MACP = @macp
					ELSE IF @giadatMB = @GiaMua2
							UPDATE BANGGIATRUCTUYEN
							SET LUONGMUA2 = @LuongMua2 +  @soluongMB
							WHERE MACP = @macp
					ELSE IF @giadatMB > @GiaMua3
							UPDATE BANGGIATRUCTUYEN
							SET GIAMUA3 = @giadatMB, LUONGMUA3 = @soluongMB
							WHERE MACP = @macp
					ELSE IF @giadatMB = @GiaMua3
							UPDATE BANGGIATRUCTUYEN
							SET LUONGMUA3 = @LuongMua3 +  @soluongMB
							WHERE MACP = @macp					
				END
			ELSE -- TH CAP NHAT BANG GIA TRUC TUUYEN CHO LENH BAN
				BEGIN
					IF @GiaBan1 = 0
							UPDATE BANGGIATRUCTUYEN
							SET GIABAN1 = @giadatMB, LUONGBAN1 = @soluongMB
							WHERE MACP = @macp
					ELSE IF @giadatMB < @GiaBan1
							UPDATE BANGGIATRUCTUYEN
							SET GIABAN1 = @giadatMB, LUONGBAN1 = @soluongMB, GIABAN2 = @GiaBan1, LUONGBAN2 = @LuongBan1,  GIABAN3 = @GiaBan2, LUONGBAN3 = @LuongBan2
							WHERE MACP = @macp
					ELSE IF @giadatMB = @GiaBan1
							UPDATE BANGGIATRUCTUYEN
							SET LUONGBAN1 = @LuongBan1 +  @soluongMB
							WHERE MACP = @macp
					ELSE IF @GiaBan2 = 0
							UPDATE BANGGIATRUCTUYEN
							SET GIABAN2 = @giadatMB, LUONGBAN2 = @soluongMB
							WHERE MACP = @macp
					ELSE IF @giadatMB < @GiaBan2
							UPDATE BANGGIATRUCTUYEN
							SET GIABAN2 = @giadatMB, LUONGBAN2 = @soluongMB, GIABAN3 = @GiaBan2, LUONGBAN3 = @LuongBan2
							WHERE MACP = @macp
					ELSE IF @giadatMB = @GiaBan2
							UPDATE BANGGIATRUCTUYEN
							SET LUONGBAN2 = @LuongBan2 +  @soluongMB
							WHERE MACP = @macp
					ELSE IF @GiaBan3 = 0
							UPDATE BANGGIATRUCTUYEN
							SET GIABAN3 = @giadatMB, LUONGBAN3 = @soluongMB
							WHERE MACP = @macp
					ELSE IF @giadatMB < @GiaBan3
							UPDATE BANGGIATRUCTUYEN
							SET GIABAN3 = @giadatMB, LUONGBAN3 = @soluongMB
							WHERE MACP = @macp
					ELSE IF @giadatMB = @GiaBan3
							UPDATE BANGGIATRUCTUYEN
							SET LUONGBAN3 = @LuongBan3 +  @soluongMB
							WHERE MACP = @macp					
				END
		END
	

   -- GOI SP KHOP LENH
   Exec SP_KHOPLENH_LO @IDLenhMB ,  @macp , @Ngay ,  @LoaiGD , @soluongMB , @giadatMB	
END


-----------    TRIGGER AFTER INSERT dbo.LENHKHOP
USE [DB_ChungKhoan]
GO
/****** Object:  Trigger [dbo].[TR_AfterInsertLK]    Script Date: 4/28/2022 10:32:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER  [dbo].[TR_AfterInsertLK]
   ON [dbo].[LENHKHOP]  AFTER  INSERT
AS 

BEGIN
	DECLARE @MaCP nchar(7), @IDLenhDat int, @SoLuongKhop int, @GiaKhop float
	SELECT @IDLenhDat = IDLENHDAT, @SoLuongKhop = SOLUONGKHOP, @GiaKhop = GIAKHOP FROM inserted
	SELECT @MaCP = (Select MACP FROM LENHDAT WHERE @IDLenhDat = ID);

	UPDATE BANGGIATRUCTUYEN
	SET GIAKHOP = @GiaKhop, LUONGKHOP = @SoLuongKhop, TONGSO = TONGSO + @SoLuongKhop
	WHERE MACP = @MaCP
END
