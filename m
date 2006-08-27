Message-ID: <44F16426.5010207@domain.hid>
Date: Sun, 27 Aug 2006 11:21:42 +0200
From: Steve Kreyer <steve.kreyer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: Timer problems?
References: <1903864415@domain.hid> <1154964748.4322.31.camel@domain.hid>	
	<44EF17E8.5040606@domain.hid>
	<slrneeuefr.v1d.Bernhard.Walle@domain.hid>	
	<44F0BBB7.7030703@domain.hid> <1156630353.4730.70.camel@domain.hid>
In-Reply-To: <1156630353.4730.70.camel@domain.hid>
Content-Type: multipart/mixed; boundary="------------090204000907010205020402"
Sender: steve.kreyer@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Bernhard Walle <bernhard@domain.hid>, xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

This is a multi-part message in MIME format.
--------------090204000907010205020402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Philippe,

disabling PM in Kernel was a good tip!

Now I can call standard linux library functions without resulting in a 
system lock up :)
But the ETIMEDOUT error when calling e.g. rt_task_wait_period or 
rt_task_sleep still persists.
The latency test gives me the following output:

-------------------------------------------------------------------------------------------------------------------
== Test mode: periodic user-mode task
== All results in microseconds
latency: failed to set periodic, code -110
warming up...
---|------------|------------|------------|--------|-------------------------
RTS| -208983.489|       0.000|  208983.489|       0|    00:00:26/00:00:26
-------------------------------------------------------------------------------------------------------------------

Also the attached application produces the below output:
-------------------------------------------------------------------------------------------------------------------
working!
working!
Warning: Cannot wait for task period! errcode=-110 110 timeout=1
working!
Warning: Cannot wait for task period! errcode=-110 110 timeout=1
-------------------------------------------------------------------------------------------------------------------

The output string "working!" and the warning messages printed at once 
and not as expected every second (see attachment)...
The TROUBLESHOOTING file has no answer to this behaviour...

Do you have any hints on this?

Regards,
Steve

Philippe Gerum wrote:
> On Sat, 2006-08-26 at 23:23 +0200, Steve Kreyer wrote:
>   
>> Hi Bernhard, :)
>> Bernhard Walle wrote:
>>     
>>> Hello,
>>>
>>> first of all: you replied to a previous mail which results in a broken
>>> thread three in the mail client ... Pleaes create new mail for new
>>> requests.
>>> The example you've provided exits immediately here because you don't
>>> wait in the main() function.
>>>   
>>>       
>> Yes, Iam aware of this, but in fact the waiting via pause or sleep in 
>> the Linux process (main function)
>> failed and results in a system lock up.
>>     
>
> The latency test issues a number of native API calls mixed with standard
> glibc calls. Does it run on your box?
>
> Btw, your .config shows that PM is enabled, which is a known source of
> latency problems; you should disable it. Additionally, make sure to read
> the TROUBLESHOOTING file thoroughly: a number of configuration caveats
> for x86 are explained, including the PM one.
>
> Last point: the kernel shipped by Kanotix might have been patched up
> beyond all recognition. Did the Adeos patch apply cleanly against it?
>
>   


--------------090204000907010205020402
Content-Type: application/gzip;
 name="example.c.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="example.c.gz"

H4sICDtj8UQAA2V4YW1wbGUuYwCdU8tu2kAUXeOvuAElGRKrQKVuClSqqNOg8pKxmy4qWSN7
ICPsGTQeQ6uWf+8dG4NxsqjCBs99nXPuo8VFGGcRg0GqIy7fPX+yWieToJrvWEfTdHPpUFow
fWlK+VrQuGb7nXaShApjtVoRW3HBYDlxnEXgjacO9Lrl7+T9MR17gfd5+S1YuOM5vLc6ndLl
jr5XPD0LXalGhiGEUqQawmeq7kCFu8AQDgRNGAyhWRqafeuV8F8J15fxJ8s5wS0onYP7Z+zS
V8L0rTJrJ3mUpxDzdQdZylQQUU3bf6wGFxqYUgjY7VuNTJj2sQhiKdagecJkpvtFFD/GFNHq
yDZlOtgyxWXEQzLzJxMbvGkwmz/ZlQa3TYkVMZkD6BrYxmqrsOiK4LTRbEPTUUqqjzCiQkgN
WBYhwEDAreF+CyXKleEbyogNryO4jn6Kpg15CcdAfZn7noFrKKYzJfDrYDVWUpGCPqoYwAf8
u7/PaVyK2VNeqiE3R/V5sQp5fL0k/0SV4GJ9om8KAaIWAoqKNd5ld4fX8WsabKjiszhlBviI
29xLtUG8K0xEv9F4uBx3GDMqsi0xgzMjVagWQ8wzoVyQl6NPYhluaByT6WgSjHzXdWYe/AXz
evA9382HWBwXWY6/jmdI8YjSvtgKpK3ytUhQK8FlmM+c5ePce/sSmIpgqoGWcC5YbWjZwcro
oVcMv7avW7oX5OZ0QXbt8mzo2rXjx40OHhZ+EWmDWfI3aDG4tZX+TwFbihdLjKMUEbGYaVZR
kTuLJJzlwfoHtWNf+E4FAAA=
--------------090204000907010205020402--

