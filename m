Message-ID: <4E44E269.3030900@domain.hid>
Date: Fri, 12 Aug 2011 10:20:57 +0200
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
References: <4E43B5FE.4040402@domain.hid>	<4E43B7E8.5000302@domain.hid>	<4E43C056.9040007@domain.hid>	<4E43EBC6.10808@domain.hid>	<4E440FAC.5020107@domain.hid>	<4E4411DB.80009@domain.hid>
	<4E444102.10206@domain.hid> <4E446345.9060705@domain.hid>
In-Reply-To: <4E446345.9060705@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Bug#637425:  gcc-4.6 issue
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: 637425@domain.hid
Cc: xenomai@xenomai.org

Hi,

On 08/12/2011 01:18 AM, Gilles Chanteperdrix wrote:
> The following patch seems to do the trick. It makes the assumption that 
> when compiling with -fomit-frame-pointer, we have one more register, so
> the "R" constraint will always be able to avoid choosing eax, and eax 
> will be free for the muxcode, so that the compiler will not choose the 
> "m" alternative.

Thanks for the update!

I can confirm that both the patch for xenomai-head and
-fno-omit-frame-pointer fix the problem.

For Debian's xenomai 2.5.6, I will just use -fno-omit-frame-pointer for now.

bye,
  Roland

