Subject: Re: error: make menuconfig to configure Xenomai cobalt
References: <1105631186.5343574.1635848055546.ref@mail.yahoo.com>
 <1105631186.5343574.1635848055546@mail.yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7823954f-00ae-dad8-1f2d-571bc10264d1@siemens.com>
Date: Tue, 2 Nov 2021 17:27:27 +0100
MIME-Version: 1.0
In-Reply-To: <1105631186.5343574.1635848055546@mail.yahoo.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: zared kamal <zaredkam@yahoo.fr>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02.11.21 11:14, zared kamal via Xenomai wrote:
> dear sir,i try to execute make menuconfig to install nano kernel xenomai with Linux_5.4 kernel, but i get the following error:
> scripts/kconfig/mconf  Kconfig
> init/Kconfig:2254: can't open file "arch/$SRCARCH/xenomai/Kconfig"
> scripts/kconfig/Makefile:33: recipe for target 'menuconfig' failed
> make[1]: *** [menuconfig] Error 1
> Makefile:590: recipe for target 'menuconfig' failed
> make: *** [menuconfig] Error 2
> 

You didn't share the Xenomai version you are using. I suspect you are on
3.0.x, and that version does not support kernel 5.4. From Xenomai 3.1
onward, there is no "$SRCARCH" anymore.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

