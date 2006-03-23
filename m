Message-ID: <4422A10B.90508@domain.hid>
Date: Thu, 23 Mar 2006 14:22:19 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: read data from serial device
References: <dvrrgc$g2a$1@domain.hid>
	<dvu50v$5pq$1@domain.hid>	<44229953.3090002@domain.hid>
	<dvu5ud$90v$1@domain.hid>
In-Reply-To: <dvu5ud$90v$1@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marco Jackel <ich@domain.hid>
Cc: xenomai@xenomai.org

Marco Jackel wrote:
> Hi,
> 
> Philippe Gerum wrote:
> 
>>Marco Jackel wrote:
>>
>>>"rt_dev_read" gives negative Results. Whats wrong?
>>
>>Which negative code is returned exactely?
> 
> It returns -5

-EIO. Except for traditional RTOS skins like VxWorks, VRTX and so on 
which have their own error list, we tend to normalize on POSIX error 
codes in all other parts of the codebase.

Regarding the EIO issue, it looks like a transmission error has been 
detected on the read-side by the 16650A driver. Jan will likely tell you 
more when time allows.

> 
> Are the error-codes documented somewehere?
> 

Yes, the documentation link on our website is a good starting point. For 
the particular EIO issue on the serial driver, I'm not sure there is a 
lot more explanations than the one above, though.

> Thanks
> Maggo
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

