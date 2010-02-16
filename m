Message-ID: <4B7ACC56.4070802@domain.hid>
Date: Tue, 16 Feb 2010 17:48:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B79A113.2020300@domain.hid>	<1266263285.2375.141.camel@domain.hid>	<4B79B972.9080000@domain.hid>
	<4B7AA5B4.8030007@domain.hid> <4B7AB628.2010405@domain.hid>
	<4B7AC76B.5070801@domain.hid>
In-Reply-To: <4B7AC76B.5070801@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] bug: patch support for intel atom n270
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Chris Cole <clecol@domain.hid>
Cc: adeos-main@gna.org

Jan Kiszka wrote:
> Chris Cole wrote:
>>> Also, I realize that the patch / kernels do not match up 100% 
>>> (although the patch applied successfully),
>>> so I'm trying that same patch on 2.6.32.7 now to see if I get the same 
>>> behavior.
>>>
>>> Chris
>>>
>> Indeed, with the adeos patch for 2.6.32.7 and a vanilla 2.6.32.7, my 
>> system is un-bootable. Is there
>> anything I can do to debug it? I'd be willing to help get a fix out but 
>> I'm not really sure where to
>> look.
> 
> Let's start with looking at and playing with .configs. Could you provide
> yours?

Also interesting: What does "unbootable" mean? Where does it hang, what
is dumped to the serial kernel console up to that point?

> 
> I also have problems with i-pipe on 2.6.32 ATM. My platform is virtual
> (QEMU/KVM), but that normally just triggers different bugs due to
> different timing (it's all x86 in the end). I hope to find some time to
> look into this next days.
> 

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

