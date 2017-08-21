References: <20170808112357.0063d74d@md1em3qc>
 <a676257d-9e88-1b81-15e6-adfffc1c7716@xenomai.org>
 <20170808134801.59ae5de6@md1em3qc>
 <86562178-3b5a-55fc-8652-dc15f228e541@xenomai.org>
 <20170808212758.550caab0@md1em3qc>
 <bf9689d1-3373-ad65-97df-a67fa639c6c3@xenomai.org>
 <20170821131253.4852c71b@md1em3qc>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <215ada11-0830-b348-1ddd-09622fa67c48@xenomai.org>
Date: Mon, 21 Aug 2017 15:25:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170821131253.4852c71b@md1em3qc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [RFC] Xenomai3 tuneables replaced by environment
	variables
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: "KISZKA, JAN" <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 08/21/2017 01:12 PM, Henning Schild wrote:
> Am Wed, 16 Aug 2017 20:13:34 +0200
> schrieb Philippe Gerum <rpm@xenomai.org>:
> 
>> On 08/08/2017 09:27 PM, Henning Schild wrote:
>>>   
>>>> Could you sketch the requirements of the app with respect to
>>>> option parsing (namespace left aside)? Is there some main
>>>> non-Xenomai executable dlopening a Xenomai-based solib defining a
>>>> set of rt-specific options?  
>>>
>>> Yes the application runs its own main() and later dlopen() s
>>> multiple libs, some of which may be linked to xenomai. The order of
>>> the dlopens seems hard to control because of static c++
>>> constructors or something alike. But i suggest we discuss the
>>> internals of that particular app after we have finished the
>>> discussion. 
>>
>> No need for this; I was not asking for details about the internals,
>> only for explicit requirements about receiving parameters / options
>> among the software components present in your app. Anyway, I think I
>> figured it out from what you've just said.
>>
>>>> It seems that you are implicitly referring to ancillaries settings
>>>> such as --silent, --verbose and --quiet as being problematic. Is it
>>>> correct or are you referring to other parameters?  
>>>
>>> If your main comes before xenomai_init() it either has to be able to
>>> ignore xenomai args or it will need to change argv/argc before
>>> dlopening.
>>>
>>> In the first case it has to know all valid args  
>>
>> ... the application accepts. Do some (non-Xenomai) dlopened libs
>> define their own option namespace the main component does not know
>> about? If not, this is only a matter of excluding/ignoring the
>> options which the application does not accept when parsing the
>> argument vector.
>>
>> xenomai_init() will do the same afterwards, ignoring the non-Xenomai
>> options transparently. The point being: who should call xenomai_init()
>> in the plugin.so file, and when.
> 
> That basically means that you can not build a very robust parser. The
> problem i see here is a typo in an otherwise valid argument. Both
> xenomai and the application will happily ignore it, creating the
> impression that it was applied.
> 

The parsing sequence is ordered: first the app, then xenomai. If some
arg is left in the argument vector returned by xenomai_init(), then such
arg must be wrong. Turn off the auto-bootstrap feature, providing your
own library constructor for the plugin module, call xenomai_init()
manually there, checking for the output vector, and there will be no
robustness issue.

-- 
Philippe.

