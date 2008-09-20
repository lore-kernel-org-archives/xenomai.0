Message-ID: <48D5653C.9030807@domain.hid>
Date: Sat, 20 Sep 2008 23:03:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <894886ec0809191200n298bc0e1n706ddf58ae987cf5@domain.hid>
	<48D3F920.5080002@domain.hid>
In-Reply-To: <48D3F920.5080002@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Creating shared objects for realtime
	and	non-realtime
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rob Wheeler <wheeler@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Rob Wheeler wrote:
>> I'm working on a large system that consists of several shared objects
>> that get linked together into an executable.  In one instance, I link
>> these shared objects together with a realtime control loop to create
>> an executable that runs on my target hardware platform.  In another
>> instance, I want to link these shared objects into an executable that
>> runs under simulation on a non-realtime platform.  I'm using posix
>> APIs throughout the shared objects for threading and mutex operations.
>>  I'd like to create a single instance of each of these shared objects
>> and do the Xenomai "skin wrapping" at the final link step, but it
>> seems that instead I need to create a realtime and non-realtime
>> version of each shared object and link against the correct ones during
>> the final link step.  Has someone else faced this issue before?
> 
> The first approach should work, what goes wrong when you try ?

Looks like I misunderstood what you are doing. When creating a shared
object, a link-edit stage happens, and if you want the resulting shared
object to use xenomai posix skin services, you have to pass the --wrap
flags.

Now, I do not really understand what you are doing, when you say
"several shared objects get linked together into an executable". What is
the result, a single executable ? Or the executable and a set of shared
objects ? Because if the result is a single executable, you can use
static libraries (i.e. ar archives) instead of shared objects, and in
this case you are able to pass the --wrap flags only for the final
linking stage.

Otherwise, if you want something completely dynamic, you may resort to
dlopen and dlsym...

-- 
					    Gilles.

