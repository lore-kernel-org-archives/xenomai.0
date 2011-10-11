Message-ID: <4E94C17C.2080702@domain.hid>
Date: Wed, 12 Oct 2011 00:21:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>	<CAMwkeZyvyhHPZTWz1LiaOhWA9TdrQaXMo833Ej5JRwJR3Da2xw@domain.hid>	<CAMwkeZxinGD8_yEYmo+ySHx9dzU6hEM4BFH4jejnTMd87f0M9Q@mail.gmail.com>	<CAMesUR4+G-Bx9tDUPajp4EcKP70zLvQuLyjLeyNpfyrmCpwBBw@domain.hid>	<CAMwkeZyQwtJbcMjOiSnmzoRDud+4=6Nt2NOcEdFG_+1QVSHoSQ@mail.gmail.com>	<CAMwkeZzajkK7gRYH5cnAW1-5HvgxQyUogDZKpms1FUyLtwxpdg@domain.hid>	<CAMesUR67RpFHRiNcd-yfR9WF2FRe1U3yBdXWP2dU30aQovCHKQ@mail.gmail.com>	<CAMwkeZxybKS+-B2C_yaYX3_XSYnAKcj8xfX_YOgQ6Kt=mNTzJQ@mail.gmail.com>	<CAMwkeZzrfuB1Uf7f1eqG8zEvgeYMXrRspzUANeOaJR2qQUmhOQ@mail.gmail.com>	<CAMesUR5AvmUDW8wq4e9EtOgnpRtMD_qe8rQe7acgFT6KzdeYAg@domain.hid>	<CAMwkeZxAvBeY=0c49N+QtUYCKCTiGo4yc9TAEQPLJAJmBXPn+A@mail.gmail.com>	<CAMesUR59KFH=hjpo=fr8DCHeg50driuitcikc5HfHTZWG5ct8A@mail.gmail.com>	<CAMwkeZyPorMx9n1Y8YAEJE4hUh49=u9Mr_tj7qzYAnquMa60rw@domain.hid>
	<CAMesUR5PsVLb16ZR1bdcbDWdUfvPxViPng+rD7mjQqy1q+OGfA@mail.gmail.com>
In-Reply-To: <CAMesUR5PsVLb16ZR1bdcbDWdUfvPxViPng+rD7mjQqy1q+OGfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Command code working with comedi not
 working	with analogy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 10/12/2011 12:12 AM, Alexis Berlemont wrote:
> The methods are not the same at that level:
> - comedi: n * dma_alloc_coherent  + a vmap at the end
> - analogy:  a big vmalloc + n * page_to_phys(vmalloc_to_page(vaddr)

I do not know if that makes a difference, but the result of
dma_alloc_coherent is memory physically contiguous, whereas it is not
the case for memory returned by vmalloc.

dma_alloc_coherent also allows the GFP_DMA32 flag if you want 32 bits
memory.

-- 
                                                                Gilles.

