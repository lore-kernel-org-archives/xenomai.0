Message-ID: <450ABC1F.8010108@domain.hid>
Date: Fri, 15 Sep 2006 09:43:43 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] invalid use of FPU in Xenomai context
References: <4509DBEB.7020707@domain.hid>
	<17674.28304.441115.152396@domain.hid>
In-Reply-To: <17674.28304.441115.152396@domain.hid>
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
To: Xenomai help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jeff Webb wrote:
>  > Does anyone have any ideas of what could trigger this besides not setting the fp attribute for the thread?
> 
> What version of Xenomai do you use ? I have updated the FPU support very
> recently, so it would be interesting to know if you also get the error
> when applying or reverting this change.

I am using Xenomai-2.2.2 with the two RTAI FIFO patches posted by Philippe a few days ago.  Do you have a patch that undoes the changes?  I could probably figure out how to generate one from subversion, if you know the revision of the change.  I do need the recent FIFO patches for the rest of my application to work properly, or I would just try an old version.  

I am using the 2.4 x86 UP kernel, if that makes any difference.

Thanks,

-Jeff

 


