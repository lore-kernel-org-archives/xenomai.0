References: <1589576.3rUbCfY1nK@indiana>
From: Jorge Ramirez Ortiz <jro@xenomai.org>
Message-ID: <56229733.6020009@xenomai.org>
Date: Sat, 17 Oct 2015 14:45:07 -0400
MIME-Version: 1.0
In-Reply-To: <1589576.3rUbCfY1nK@indiana>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ARM64 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

We are finishing up the aarch64 integration of the patches contributed to the
project by the team at http://www.mperpetuo.com/ for I-pipe and Xenomai (this
should happen within the next couple of weeks).
The development and validation is being done on the Hikey board (8 cores A53
Hisilicon SoC) [1]; very soon we will add support for the Dragon 410c (4 cores
A53 Qualcomm SoC) [2] and probably some of the other 96Boards that will be
coming soon.

Incidentally Xenomai/Cobalt on Hikey was demonstrated during Linaro Connect 2015
in SFO last month.

So yes, you can consider aarch64 as an important part of the Xenomai roadmap

[1] https://www.96boards.org/products/ce/hikey/
[2] https://www.96boards.org/products/ce/dragonboard410c/


On 10/17/2015 11:06 AM, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> I have been searching on the web if Xenomai works in ARM64 or not. I have 
> found some mails on the list in march, but I don't know if it's supporting now 
> or not.
> 
> Please, could you explain the status of the port?
> 
> Best regards,
> 
> Leopold
> 
> 
> [1] https://xenomai.org/pipermail/xenomai/2015-March/033702.html
> 

-- 
jro

