References: <bc0b17815f267a151732.1480498947@devws148.be.alcatel-lucent.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d85e331d-4ae8-767d-4e8c-f4c051e1ceb7@xenomai.org>
Date: Thu, 1 Dec 2016 18:44:31 +0100
MIME-Version: 1.0
In-Reply-To: <bc0b17815f267a151732.1480498947@devws148.be.alcatel-lucent.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] psos: add interface to configure region 0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org

On 11/30/2016 10:42 AM, Ronny Meeus wrote:
> In the pSOS interface region 0 can be used by applications to allocate
> memory from. It contains 'system' memory and is created by default during
> system init. Region 0 is currently not supported by the xenomai psos skin.
> 
> This patch adds functionality to configure a 'pseudo 0' region that will
> be used if applications allocate memory from region 0.
> 
> To enable this, following code needs to be added to the early application
> init code to configure region 0 (before applications use rn_getseg(0,...)).
> 
> unsigned long rnid,rsize;
> unsigned long rn_0_size = 128000;
> unsigned long unit_size = 128;
> 
> rn_create("_RN0",malloc(rn_0_size),rn_0_size, unit_size, 0, &rnid, &rsize);
> set_pseudo_rn0_id(rnid);
> 
> diff --git a/include/psos/psos.h b/include/psos/psos.h
> --- a/include/psos/psos.h
> +++ b/include/psos/psos.h
> @@ -253,6 +253,8 @@ u_long q_vbroadcast(u_long qid,
>  		    u_long msglen,
>  		    u_long *count_r);
>  
> +void set_pseudo_rn0_id(unsigned long id);
> +

I'm fine with the reason to add support for RN#0, not with the way you
do it. The proper logic would rather be:

- define proper tunable psos_rn0_size representing the size of RN#0,
defaulting to 0 bytes
- create RN#0 from psos_init() if psos_rn0_size is non-zero

That would address several issues:

- eliminate the quite ugly remapping from 0 to some pseudo rnid
- keep the tunable bits in the emulator core (this stuff is no
application's business in the Xenomai model).
- allow pulling memory from RN#0 from static C++ ctors and other library
init code which may run before the application entry point is reached.
i.e:
http://xenomai.org/2015/05/application-setup-and-init/#Initialization_sequence

The application would only have to call
set_config_tunable(psos_rn0_size, <size>) from a setup() handler, as
documented here (likewise for the unit size):

http://xenomai.org/2015/05/application-setup-and-init/#Overriding_factory_default_values_of_tunables

-- 
Philippe.

