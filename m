Message-ID: <4ECA2FF8.7040406@domain.hid>
Date: Mon, 21 Nov 2011 12:03:20 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CA+eKTkZ_ymqXx_Nc_9v1HRtYTqSjYqzdN56HCjzO+x14zcUwcg@domain.hid>
In-Reply-To: <CA+eKTkZ_ymqXx_Nc_9v1HRtYTqSjYqzdN56HCjzO+x14zcUwcg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [xenomai-help] Error return with a4l_sync_write
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hadrien Caron <hadrien.caron@domain.hid>
Cc: xenomai@xenomai.org

On 11/21/2011 11:44 AM, Hadrien Caron wrote:
> Hello to all !
> 
> I have a small problem using a4l_sync_write : I am using it inside a
> program that should write on a digital port.
> The function a4l_sync_write returns a value of -38.
> But according to the documentation, there is only 3 possible error
> possibles :
> EINVAL = 22
> EFAULT = 14
> ENOMEM = 12
> 
> So what is error 38 ? Is it missing from the documentation ? Or am I doing
> something wrong ?

With "http://www.xenomai.org/index.php/Resolving_Error_Codes" I get:

$ errno 38
#define	ENOSYS		38	/* Function not implemented */

Wolfgang.


