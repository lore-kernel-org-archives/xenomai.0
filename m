MIME-Version: 1.0
In-Reply-To: <0dac1a39-4e56-5174-825a-3256876a7577@xenomai.org>
References: <388c7d18-7726-9d20-b9c2-2113115fa348@iit.it>
 <0dac1a39-4e56-5174-825a-3256876a7577@xenomai.org>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 29 Jan 2018 13:18:23 -0500
Message-ID: <CALLqZ8RhtguYZ5O16OiF88UWzyMdRQnjKMLW+xrYyJs351-5Hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [RTnet] 3.0.6 xenomai/net/drivers 'debug' symbol
	redeclared
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

This is fixed in stable-3.0.x

On Mon, Jan 29, 2018 at 1:15 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 01/29/2018 07:01 PM, alessio margan wrote:
>> Hi all,
>>
>> I was installing xenomai 3.0.6 (
>> https://xenomai.org/downloads/xenomai/stable/ ) on a 4.9.51 kernel, I
>> get the following errors
>>
>> drivers/xenomai/net/drivers/r8169.c:131:12: error: =E2=80=98debug=E2=80=
=99 redeclared as
>> different kind of symbol
>>
>>  static int debug =3D -1;
>>             ^
>> In file included from arch/x86/xenomai/include/asm/xenomai/thread.h:25:0=
,
>>                  from include/xenomai/cobalt/kernel/thread.h:35,
>>                  from include/xenomai/cobalt/kernel/sched.h:24,
>>                  from include/xenomai/rtdm/driver.h:37,
>>                  from drivers/xenomai/net/stack/include/rtnet.h:99,
>>                  from drivers/xenomai/net/stack/include/rtskb.h:32,
>>                  from drivers/xenomai/net/stack/include/rtdev.h:37,
>>                  from drivers/xenomai/net/stack/include/rtnet_port.h:32,
>>                  from drivers/xenomai/net/drivers/r8169.c:82:
>> ./arch/x86/include/asm/traps.h:13:17: note: previous declaration of
>> =E2=80=98debug=E2=80=99 was here
>>  asmlinkage void debug(void);
>>
>> drivers/xenomai/net/drivers/igb/igb_main.c:280:12: error: =E2=80=98debug=
=E2=80=99
>> redeclared as different kind of symbol
>>  static int debug =3D -1;
>>             ^
>> In file included from arch/x86/xenomai/include/asm/xenomai/thread.h:25:0=
,
>>                  from include/xenomai/cobalt/kernel/thread.h:35,
>>                  from include/xenomai/cobalt/kernel/sched.h:24,
>>                  from include/xenomai/rtdm/driver.h:37,
>>                  from drivers/xenomai/net/stack/include/rtnet.h:99,
>>                  from drivers/xenomai/net/stack/include/rtskb.h:32,
>>                  from drivers/xenomai/net/stack/include/rtdev.h:37,
>>                  from drivers/xenomai/net/stack/include/rtnet_port.h:32,
>>                  from drivers/xenomai/net/drivers/igb/e1000_hw.h:31,
>>                  from drivers/xenomai/net/drivers/igb/e1000_mac.h:28,
>>                  from drivers/xenomai/net/drivers/igb/igb.h:30,
>>                  from drivers/xenomai/net/drivers/igb/igb_main.c:56:
>> ./arch/x86/include/asm/traps.h:13:17: note: previous declaration of
>> =E2=80=98debug=E2=80=99 was here
>>  asmlinkage void debug(void);
>>
>>
>> there is a workaround or I should try git://xenomai.org/xenomai-3.git
>> wip/rtnet-fixes and then wait for a 3.0.7 ?
>>
>
> The rule of thumb is to track and pull the latest code from the
> stable-3.0.x branch at git://git.xenomai.org/xenomai-3.git.
>
> --
> Philippe.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

