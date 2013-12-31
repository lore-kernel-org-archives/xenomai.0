Message-ID: <52C2608E.2030609@denx.de>
Date: Tue, 31 Dec 2013 07:13:34 +0100
From: Stefan Roese <sr@denx.de>
MIME-Version: 1.0
References: <1388416530-5865-1-git-send-email-sr@denx.de>
 <52C1EA3B.2030009@xenomai.org>
In-Reply-To: <52C1EA3B.2030009@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] hal/arm: Add Zynq v3.5.7 patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 30.12.2013 22:48, Gilles Chanteperdrix wrote:
> On 12/30/2013 04:15 PM, Stefan Roese wrote:
>> Xilinx Zynq is already supported in the mainline Xenomai git repository.
>> This patch adds support for the v3.5.7 Linux Kernel with the latest
>> arm-6 i-pipe patch additionally to the already present v3.8 support.
> 
> Sorry, I can not take these patches:
> - they contain changes in the I-pipe core not related to the Zynq
> architecture, these should be submitted separately as patches to the
> I-pipe git itself;

Okay.

> - they contain changes in the Linux code, not related to Zynq either,
> probably due to a mismatch between the stable revision you are using. In
> order to use a more recent revision, please post a patch modifying the
> I-pipe git to use that more recent stable revision;

Its the other way around. The Xilinx code is based on Linux v3.5. And
the i-pipe patch is based on v3.5.7. So the pre-patch also includes the
move for the xilinx code from v3.5 to v3.5.7.

> - they contain a defconfig file, if you want to make that file
> available, please put it to some ftp or http server somewhere and put
> the URL in the readme;

Okay.

> Really, the pre and post patches should be short, here they are enormous.

Mostly because of the v3.5 -> v3.5.7 move for the Xilinx code. Should I
post this v3.5 -> v3.5.7 diff as a separate patch?

Thanks,
Stefan


