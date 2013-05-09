Message-ID: <518BAF44.9060803@xenomai.org>
Date: Thu, 09 May 2013 16:14:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rOMJi4u7sm9+a79aJ2GhhtJY7B5QD0+tVxsN7KoFMqxCw@mail.gmail.com>	<518A5F0C.50403@xenomai.org>	<CAPpP=rNt32NFsF5LhJybpcBRfm33za8kP2tQj+t4Vs9-hkH48w@mail.gmail.com>	<518ABA3D.5070106@xenomai.org>	<CAPpP=rOQm+GBuoB5KuAiAo5nG=HzggXb7CyLaP-SHAwebykPUw@mail.gmail.com>	<518B8C50.2050107@xenomai.org>	<CAPpP=rNkQTDCfRAxpN5wPNK-5R-4gngpxFGUCiqT2T8gwMKJRg@mail.gmail.com>	<518BA407.8020103@xenomai.org>
	<CAPpP=rNCxHUfcBS7djmv8i+Er2PpXBdO101LfcxaZswzc9eBnw@mail.gmail.com>
In-Reply-To: <CAPpP=rNCxHUfcBS7djmv8i+Er2PpXBdO101LfcxaZswzc9eBnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Posix] I/O multiplexing with select
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alex alex <duch.alexandre@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 05/09/2013 04:09 PM, alex alex wrote:

> I you call pthread_set_name_np for a thread that may not exist, this is
> 
>> an issue which has already been fixed:
>>
>>
> I have tried to used pthread_set_name_np with a thread that may not exist
> but it correctly returns ESRCH.
> 
> I've also tried to reproduce this bug by creating and canceling a thread in
> a loop, but I can not have this bug anymore.


Ok, are you sure that the string you passed to pthread_set_name_np could
not have been overwritten in the mean time? For instance by passing to
the thread an argument which resides on the caller stack. Like for instance:

void *thread(void *cookie)
{
	pthread_set_name_np(pthread_self(), (char *)cookie);
	
	/* ... */
}

void create_thread(void)
{
	char name[]= "name";
	pthread_t tid;

	pthread_create(&tid, NULL, thread, name);
}

int main(void)
{
	create_thread();

	/* ... */

}

-- 
                                                                Gilles.

