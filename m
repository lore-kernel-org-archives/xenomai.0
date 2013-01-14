Message-ID: <50F3DD9A.9050306@gmail.com>
Date: Mon, 14 Jan 2013 11:27:38 +0100
From: Stefan Roese <stefan.roese@gmail.com>
MIME-Version: 1.0
References: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>
In-Reply-To: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mfornero@aanddtech.com
Cc: Xenomai@xenomai.org

Hi Matthew,

On 01/12/2013 06:21 PM, mfornero@aanddtech.com wrote:
>    I'm looking for recommendations on how to best port ipipe support to a
>    new ARM SoC. The SoC has started to show up in mainline, but many of
>    the features haven't made it over yet. Xilinx maintains a git repo
>    here:
> 
>    git://git.xilinx.com/linux-xlnx.git
> 
>    And it look like they've synced with mainline 3.6
> 
>    The two approaches I've considered were either trying to port ipipe to
>    stock 3.6 (or at least the generic and ARM bits) or trying to backport
>    the Xilinx code to 3.5.3. I started with the later approach, but some
>    changes to the common clock architecture between 3.5 and 3.6 make this
>    somewhat difficult.
> 
>    Any thoughts on which approach would be better?

I'm also working on supporting Zynq in I-pipe. My approach was to use
the Xilinx 3.5.0 code version (git tag "xilinx-14.3-build2"). And port
the I-pipe version from Gilles git repository to it. I still need to do
some cleanup then I can send you the latest version.

Best regards,
Stefan



