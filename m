Message-ID: <48D7DAD4.4070304@domain.hid>
Date: Mon, 22 Sep 2008 19:50:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200809192047.20277.niklaus.giger@domain.hid>
	<48D5672E.6000006@domain.hid>
In-Reply-To: <48D5672E.6000006@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Signature of kernel_init of xenomai-solo?
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Niklaus Giger wrote:
>> Hi 
>> Shouldn't the signature not bee
>> STATUS kernelInit(FUNCPTR rootRtn, int argc, const char * argv[]);
>> instead of
>> STATUS kernelInit(FUNCPTR rootRtn, int argc, char *const argv[]);
>> I think this would be more like a classical definition "main".
>>
>> I have a classical definition of
>>   int main(int argc, char *argv[])
>> which permits mit to pass it to , const char * argv[]),
>> whereas char *const argv[] is not an allowd cast.
> 
> Personnaly, I always used:
> 
> int main(int argc, const char *const argv[])
> 
> until the day when I started using getopt or getopt_long, which
> prototype are:
> 
> int getopt(int argc, char * const argv[],
>                   const char *optstring);
>  int getopt_long(int argc, char * const argv[],
>                   const char *optstring,
>                   const struct option *longopts, int *longindex);
> 
> So, now, I always use:
> 
> int main(int argc, char *const argv[])
> 
> Maybe that is also the reason for the prototype of kernelInit ?
> 

Yes it is. Even if that looks a bit funky, we are still supposed to be able to
poke to the arg memory, even if we can't change the pointers to it.

-- 
Philippe.

