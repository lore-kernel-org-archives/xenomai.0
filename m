References: <tencent_7BB3FFF260BB49F738A5294C@qq.com>
 <20151113132245.GC1820@hermes.click-hack.org>
From: Jorge Ramirez Ortiz <jro@xenomai.org>
Message-ID: <564678CD.6050505@xenomai.org>
Date: Fri, 13 Nov 2015 18:57:01 -0500
MIME-Version: 1.0
In-Reply-To: <20151113132245.GC1820@hermes.click-hack.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] system crushed using igh ethercat master 1.52
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: wangxueqin@tc-tech.net
Cc: gilles.chanteperdrix@xenomai.org, xenomai@xenomai.org

On 11/13/2015 08:22 AM, Gilles Chanteperdrix wrote:
> On Fri, Nov 13, 2015 at 01:48:25PM +0800, 使用系统默认昵称 wrote:
>> hi,we modified and complied the examples/xenomai/ example program.
>> and run it in x86 and ARM(beagleboard black) board to drive a
>> servo. the linux system can drive a servo, but get crushed in 1-2
>> hours on x86 platform. however, the cross-complied program crushed
>> at starting it on ARM platform.
>>
>>
>> we complied the realtime program and can run without problem.
>> however, it cruched when we add the igh ethercat APIs.
> 
> I suggest you direct your question to igh then.
> 

where is the code that you are using to drive the servo?

I am driving a Grove servo [1] using Xenomai3 and the following driver [2] to
generate the PWM with one of the available GPIOs - maybe you want to give it a
go if you are also using a gpio pin?


[1] http://www.seeedstudio.com/depot/Grove-Servo-p-1241.html
[2]
http://git.xenomai.org/xenomai-jro.git/commit/?h=hikey&id=7a9e0b853fd3f51699220c78cb7543c1f5723ce3

-- 
jro

