References: <SG2PR04MB0925FDF5009929D778345754F2DA0@SG2PR04MB0925.apcprd04.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a19d74e0-5050-5d61-daab-48624caabbce@xenomai.org>
Date: Wed, 12 Oct 2016 11:22:05 +0200
MIME-Version: 1.0
In-Reply-To: <SG2PR04MB0925FDF5009929D778345754F2DA0@SG2PR04MB0925.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Compatibility VS Specific HW
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "RAGAGLIA Matteo (Matteo)" <matteo_ragaglia@yanmar.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/11/2016 10:35 AM, RAGAGLIA Matteo (Matteo) wrote:
> Hi everyone,
> I have the following HW configuration:
>    x) CPU:                             INTEL CORE I7-6800K 3.4G;
>    x) Mother board:          Asus MB X99-A/USB3.1;
>    x) Graphic card:             ASUS STRIX GTX1080 A8G;
> 
> Does anyone know if there is some kind of incompatibility between Xenomai and the listed components?
> Thank you in advance.

I don't have this information, but if you already have this hw at hand,
you could check for the most common sources of unexpected latency on x86
by running the hw latency detector, without installing Xenomai yet. A
revamped version of this code was posted back in August to the lkml [1],
it is integrated into the regular tracing infrastructure; it is
available from linux-next/master at the moment.

During the tests, you may want to make sure that graphical activity
happens to exercise the gpu support code, and the usb plug&play as well
if that makes sense. Whether thermal events could be triggered by your
workload should be considered too.

[1] https://lkml.org/lkml/2016/8/4/348

-- 
Philippe.

