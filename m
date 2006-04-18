Message-ID: <44450DDF.9080205@domain.hid>
Date: Tue, 18 Apr 2006 18:03:43 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] strangeness at kernel configuration
References: <20060418144146.GA4482@domain.hid>
	<20060418153508.GB4482@domain.hid>
In-Reply-To: <20060418153508.GB4482@domain.hid>
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
To: Luotao Fu <l.fu@domain.hid>
Cc: xenomai@xenomai.org

Luotao Fu wrote:
> seemed that I'm getting Kerneloops trying loading rtdm drivers:
> This is what I see while trying to load the timerbench driver. 
>

Your configuration works perfectly here over #944. You might want to 
restart building from a freshly patched kernel anew, there seems to be 
something badly broken in your current tree, perhaps some mismatching 
modules that have not been recompiled properly?

-- 

Philippe.

