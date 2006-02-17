Message-ID: <43F5DD73.2030008@domain.hid>
Date: Fri, 17 Feb 2006 15:28:03 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] no-brainer realtime issue
References: <C01B17DA.2441%steve@domain.hid>
In-Reply-To: <C01B17DA.2441%steve@domain.hid>
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
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Steven Seeger wrote:
> Maybe I didn't set it up right? I followed the instructions in the
> README.INSTALL file. Attached is my linux tree's .config.
> 

Try enabling the SMI workaround (Xeno's "Machine" menu), just in case, since you 
are running a Geode box.

> Steven
> 
> 
>>Until those numbers are sane, there is no point in trying anything else
>>though.
>>
>>Ok, the testsuite clearly fails on your board, and something in the current
>>setup 
>>prevents any real-time use. .config would help.
>>
> 
> 


-- 

Philippe.

