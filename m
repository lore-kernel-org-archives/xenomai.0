From: Marco Jackel <ich@domain.hid>
Date: Thu, 23 Mar 2006 14:21:17 +0100
Message-ID: <dvu7cd$eig$1@domain.hid>
References: <dvrrgc$g2a$1@domain.hid>	<dvu50v$5pq$1@domain.hid>
	<17442.39678.261159.421057@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <17442.39678.261159.421057@domain.hid>
Sender: news <news@domain.hid>
Subject: [Xenomai-help] Re: read data from serial device
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Marco Jackel wrote:
>  > "rt_dev_read" gives negative Results. Whats wrong?
> 
> It depends on the return value, see:
> 
> http://download.gna.org/xenomai/documentation/trunk/html/api/group__rtserial.html
> 

Yes, I saw that, but I get "-5" as error code (I forgot to write that in
my last posting) and I don't know what it means. At the dokumentation
there are only 4 possibilities:
-ETIMEDOUT
-EINTR (interrupted explicitly or by signal)
-EAGAIN (no data available in non-blocking mode)
-EBADF (device has been closed while reading)

Regards
Maggo


