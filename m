Message-ID: <472F5B18.6010607@domain.hid>
Date: Mon, 05 Nov 2007 19:04:08 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <44D6D942646F9E43B7CFFFD3F250EDCD08E9C9@domain.hid>
In-Reply-To: <44D6D942646F9E43B7CFFFD3F250EDCD08E9C9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Binding failed: Bad address
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: MEYLAN Jean-philippe <Jean-philippe.Meylan@domain.hid>
Cc: xenomai@xenomai.org

MEYLAN Jean-philippe wrote:
> Hi,
> 
> I've switched to the 2.4 RC6 version of Xenomai and I get this error :
> 
> Xenomai: Binding failed: Bad adress.
> 
> when I try to launch an user space application. My application was running
> successfully with the v.2.3 of Xenomai.
> 
> Do you have any idea of what causes this error ?
>

Syscall returned -ENOBRAIN on my side. This has been fixed in the trunk. 
Please resync.

> Thank you very much for your reply.
> 
> Best regards.
> 
> Jean-Philippe
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


