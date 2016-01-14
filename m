References: <CA+CJOCxoqmA1r0sGb_LwqvsXPzMG485YqUmR83hsfT2mTD6xnQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5697D9DB.6070909@xenomai.org>
Date: Thu, 14 Jan 2016 18:24:43 +0100
MIME-Version: 1.0
In-Reply-To: <CA+CJOCxoqmA1r0sGb_LwqvsXPzMG485YqUmR83hsfT2mTD6xnQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] VxWorks API on Xenomai 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nicolas SCHURANDO <schurann@ext.essilor.com>, xenomai@xenomai.org

On 01/14/2016 10:22 AM, Nicolas SCHURANDO wrote:
> Hello everyone,
> 
> In an attempt to migrate from Xenomai 2.6.4 on a Raspberry Pi 1 to Xenomai
> 3.0.1 on a Raspberry Pi 2, I get an error when trying to spawn a VxWorks
> task in a fairly simple test program. Here is the output :
> 
>    0"000.064| WARNING: [main] Xenomai compiled with full debug enabled,
>>                               very high latencies expected
>> [--enable-debug=full]
>>  [i] [main] Hello, launching root task ...
>>  200"747.521| BUG in wind_task_normalize_priority():
> 
> 
> The corresponding code is :
> 
> int main(int argc, char *argv[]) {
> 
> 
>> /* Hello world */
>> printf(" [i] [%s] Hello, launching root task ...\r\n", __FUNCTION__);
> 
> 
>> /* Spawn root task */
>> taskSpawn("root_task", 100, 0, 16 * 1024, (FUNCPTR) &root_task, 0, 0, 0,
>> 0, 0, 0, 0, 0, 0, 0);
> 
> 
>> [...]
> 
> 
>> }
> 
> 
> I've tracked down the problem to threadobj_high_prio being equal to 0,
> hence the following function expecting priorities from -1 to 0. I however
> have no idea where threadobj_high_prio gets its value from.
> 

Your application is not initializing properly, the Xenomai libs are not
bootstrapped. There are detailed explanations about the init flow here:
http://xenomai.org/2015/05/application-setup-and-init/

-- 
Philippe.

