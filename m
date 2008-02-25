Message-ID: <47C277E4.3090506@domain.hid>
Date: Mon, 25 Feb 2008 09:10:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <606588375@domain.hid> <200802250451.22841.berlemont.hauw@domain.hid>
In-Reply-To: <200802250451.22841.berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and Virtex II Pro (PPC405)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Joachim Meyer <Jogi95@domain.hid>
Cc: xenomai@xenomai.org

Alexis Berlemont wrote:
>>> Which framework ?
>> An application, basing on this framework (written by someone at my college,
>> who isn't here anymore), which bases on rtai, was running on linux on a
>> celeron. This application should be ported to the Virtex 2 Pro by me. So I
>> ask myself how hard it would be, to use Xenomai (perhaps with this "rtai
>> skin??") instead of rtai.
> 
> It depends on the RTAI functions which are called in your framework. I am not 
> sure that 100% of the API is implemented. I did not have time to have a 
> closer look... Maybe someone else has the answer...

The RTAI skin is kernel-space only so far, and it doesn't implement to 
full set of RTAI services - which would be a lot of work to do...

Take a look at the Native API of Xenomai. It is quite similar to RTAI, 
but you may find it way more consistent. Unless there is a hard 
requirement to keep the OS layer of that frame work at RTAI level, 
adopting to Native services should be the preferred way to go.

Jan

