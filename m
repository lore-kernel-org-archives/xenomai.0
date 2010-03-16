Date: Tue, 16 Mar 2010 10:12:23 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4B9E7949.5060606@domain.hid>
Message-ID: <alpine.DEB.1.10.1003161012150.29063@domain.hid>
References: <alpine.DEB.1.10.1003151439040.27204@domain.hid>
	<1268663424.27899.226.camel@domain.hid>
	<4B9E6312.6010109@domain.hid>
	<1268673002.27899.230.camel@domain.hid>
	<4B9E7520.8000107@domain.hid>
	<1268676605.27899.233.camel@domain.hid>
	<4B9E7949.5060606@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] Problem throwing a C++ Exception on Blackfin
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


> "clean" abort. So, I guess there is no -fexceptions issue.
> Sorry for the noise.

Hm, it seems I'm to blame for unnecessary noise on this list - the problem appears even without any task switching in the process. Sorry that I didn't consider to try that first, I was somehow sure it's related to the extra task. I think I better move over to the uClinux etc Forums...

Even this is sufficient to trigger the problem: int main(){try{throw "foo";}catch(...){}};

Kolja




