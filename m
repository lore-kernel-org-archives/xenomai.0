References: <0f27712b-d49f-d36d-53b9-9ef3036add43@openmailbox.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f9843934-debf-05eb-a00c-f9f6bb692a36@xenomai.org>
Date: Thu, 7 Jul 2016 10:16:15 +0200
MIME-Version: 1.0
In-Reply-To: <0f27712b-d49f-d36d-53b9-9ef3036add43@openmailbox.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mercury 3.0.2 on Raspberry Pi 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: dominikk <dominikk@openmailbox.org>, xenomai@xenomai.org

On 07/07/2016 08:02 AM, dominikk wrote:
> Hi there,
> 
> we are trying to run the Mercury core on a Raspberry Pi 3. The code
> compiles fine and the latency test (/usr/xenomai/bin/latency) runs
> successfully.
> 
> However, running a dummy application (i.e. Hello World) results in the
> following error:
> 
> # sudo ./test
>    0"003.571| WARNING: [main] failed to initialize multi-threading
>               package
>    0"003.791| WARNING: [main] setup call copperplate failed
>    0"003.925| BUG in xenomai_init(): [main] initialization failed, 22?
> 
> Similarly, when running alatency:
> 
> # sudo /usr/xenomai/demo/altency
>    0"003.571| WARNING: [main] failed to initialize multi-threading
> 	      package
>    0"003.791| WARNING: [main] setup call copperplate failed
>    0"003.925| BUG in xenomai_init(): [main] initialization failed, 22?
> 
> Same results for hdb or any other application linked with the Alchemy skin.
> 
> We are running (raspberry) Kernel 4.4.13 with RT patches and compiled
> xenomai with the following flags:
> 
> Build args:
> CFLAGS=-march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard
> LDFLAGS=-march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard
> --with-core=mercury --disable-debug --enable-clock-monotonic-raw
> --enable-smp
> 
> Any advice would be greatly appreciated.
> 

--disable-clock-monotonic-raw should help.

-- 
Philippe.

