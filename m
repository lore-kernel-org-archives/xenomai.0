From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4637A8AA.1080506@domain.hid>
References: <4637A8AA.1080506@domain.hid>
Content-Type: text/plain
Date: Wed, 02 May 2007 09:33:20 +0200
Message-Id: <1178091201.5111.29.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] port to kernel 2.6.21 ?
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: trem <trem@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Tue, 2007-05-01 at 22:52 +0200, trem wrote:
> Hi
> 
> I've seen that kernel 2.6.21 has been inserted in the git repository.
> I'm interested to help porting adeos from 2.6.20 to 2.6.21. But I think
> that it's not very nice if two people work on the same thing. So I'm
> asking who works on what ?

Adeos maintainers are:

Gilles Chanteperdrix: arm
Wolfgang Grandegger: ppc32
Alexis Berlemont: 2.4/x86
/me: basically, the rest.

Those people produce the "official" Adeos patches for any given
architecture, integrating contribs from others.

I'm usually the one who upgrades the Adeos core to the next major Linux
release. In the 2.6.21 case, I did not start this work yet, and probably
won't be able to do it before a few weeks. So, if you want to handle
this task for 2.6.21/x86_64, please do.

-- 
Philippe.



