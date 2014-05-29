Message-ID: <53875106.6060202@xenomai.org>
Date: Thu, 29 May 2014 17:23:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OFBAF613A3.27D3BC8A-ONC1257CE7.003515C1-C1257CE7.0042F1F4@selex-es.com>
 <5387289F.2090404@xenomai.org>
 <OFCCBDF17D.EBCF7A9B-ONC1257CE7.00512F0F-C1257CE7.00529C5C@selex-es.com>
In-Reply-To: <OFCCBDF17D.EBCF7A9B-ONC1257CE7.00512F0F-C1257CE7.00529C5C@selex-es.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] User Space Interrupt not working
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: matteo.semmoloni@selex-es.com
Cc: xenomai@xenomai.org

On 05/29/2014 05:02 PM, matteo.semmoloni@selex-es.com wrote:
> 
> Thanks, I'm running on ARM platform Xilinx Zynq.
> 
> I have a doubt about patch suggested; Ipipe version is 1, but Ipipe version
> mentionated in your post is 3. Is it possibile that I'm using an older
> Ipipe patch? Lines suggested by your post do not match with my Ipipe.
> 
> I'm using linux-xilinx release 14.5 (vanilla kernel 3.8.0 ) for zync soc,
> and I've applied this ipipe patch: ipipe-core-3.8-arm-1.patch
> 
> Am I using a wrong ipipe patch? I'm a little bit confuse.

The patch I pointed you to is for I-pipe 3.14 (which is the I-pipe patch
we are currently working on, sorry, we only have the ressources to work
on only one I-pipe patch at a time), but should apply to earlier releases.

-- 
                                                                Gilles.

