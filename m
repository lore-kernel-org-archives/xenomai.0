Message-ID: <530766CD.3060707@xenomai.org>
Date: Fri, 21 Feb 2014 15:46:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1392993075.52404.YahooMailNeo@web140605.mail.bf1.yahoo.com>
In-Reply-To: <1392993075.52404.YahooMailNeo@web140605.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] User Space Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/21/2014 03:31 PM, Bruno Tunes de Mello wrote:
> Hi,
>
> I'm using a Sabre Lite board with IMX6Q for a project.
> I
> installed xenomai with the kernel 3.0.35 from boundary Devices, its not
> the version indicated in README file, but I applied the patches and it
> seems work. When it boots can see the messages:
>
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/arm started.
> Xenomai: scheduling class idle registered.
> Xenomai: scheduling class rt registered.
> Xenomai: real-time nucleus v2.6.3 (Lies and Truths) loaded.
> Xenomai: debug mode enabled.
> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
>
> But the user space is not working. When I try to execute latency and xeno-test commands I get a error message: not
>   found.
>
> linaro@linaro-alip:/usr/xenomai/bin$ ./latency
> bash: ./latency: No such file or directory
> linaro@linaro-alip:/usr/xenomai/bin$ ./xeno-test
> bash: ./xeno-test: /usr/xenomai/bin/xeno-test-run: bad interpreter: No such file or directory
> linaro@linaro-alip:/usr/xenomai/bin$ sudo ./xeno latency
> ./xeno: 15: exec: /usr/xenomai/bin/latency: not found
>
> The only command that work is xeno-config. I started using Linux for this project so I don't know how to solve it.
>
> I
>   tried to search some solution on mailing list, but anything yet. In
> troubleshooting guide I read about EABI and OABI compilers mismatch, but
>   I compiled both kernel and user space with Linaro toolchain
> (arm-linux-gnueabi). I tried with Ubuntu cross-compiler too
> (arm-linux-gnueabihf), but same result.

Xenomai user-space support is probably mis-compiled:
- either you did not compile it for ARM;
- or you compile it with a toolchain which is not the same as the one 
used to generate the rest of the root filesystem.


-- 
					    Gilles.

