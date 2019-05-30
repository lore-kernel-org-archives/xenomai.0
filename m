From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Migration from Xenomai v2 to v3 w/ Mercury kernel possible ?
References: <jPR.3teSK.63VQ6z6W8Et.1Sxnsq@seznam.cz>
Message-ID: <945d1319-17a3-a0a8-23e5-3f4c19eb9398@xenomai.org>
Date: Thu, 30 May 2019 13:35:26 +0200
MIME-Version: 1.0
In-Reply-To: <jPR.3teSK.63VQ6z6W8Et.1Sxnsq@seznam.cz>
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
To: ajohn@post.cz, xenomai@xenomai.org

On 5/30/19 2:03 AM, Robie via Xenomai wrote:
> 
> Hi,
> 
> 
> 
> 
> I am going to migrate older Xenomai v2 application to Xenomai v3.
> 
> 
> 
> 
> While still learning all the impressive improvements of Xenomai v3, I 
> struggle to figure out if it would be possible to migrate Xenomai v2 
> application (x86-64, native skin, + few RTDM drivers) to be executable on 
> both the Mercury and Cobalt kernels keeping the same app's source code. 
> 
> 
> 
> 
> I am thinking about having the Mercury variant for non real-time dev&
> debbuging on common distribution kernel while the Cobalt version would run 
> on dedicated hardware with patched/tuned kernel.
> 
> 
> 
> 
> I wonder if old style Xenomai v2 RTDM drivers and "native" application may 
> compile and run with Mercury after some adaptations.
> 
> 
> 
> I learned the Cobalt base environment with v2 "native" compatibility 
> requires something like
> 
> configure --core=cobalt
> 
> and compilation w/ xeno-config –native
> 
> That seems to be viable migration path.
> 
> 
> 
> 
> 
> But for Mercury - which xeno-config settings to use for user space app and 
> for RTDM driver/module when neither --native nor --rtdm nor –compat switches
> are applicable ?
> 
> 
> 
> 
> Loking at web resources like https://xenomai.org/documentation/xenomai-3/
> html/MIGRATION/(https://xenomai.org/documentation/xenomai-3/html/MIGRATION/)
>  but no luck so far.
> 

All Xenomai 3 APIs in userland can build and run on top of the mercury
layer, including the legacy "native" API which is known as "alchemy" in
Xenomai 3. However, the issue is going to be with drivers, there is no
RTDM in-kernel API available for the single kernel configuration. There
has been a proof-of-concept in the early days [1], but this code has not
been maintained.

[1] git://archive.xenomai.org/rtdm-native.git

-- 
Philippe.

