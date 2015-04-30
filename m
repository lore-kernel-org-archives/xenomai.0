Message-ID: <5541DB07.4050304@xenomai.org>
Date: Thu, 30 Apr 2015 09:34:31 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5541BFA1.40101@bmwedler.de>
In-Reply-To: <5541BFA1.40101@bmwedler.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3.0rc creating alchemy task in a shared object
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Registrierungen <regist@bmwedler.de>, xenomai@xenomai.org

On 04/30/2015 07:37 AM, Registrierungen wrote:
> Hello,
> 
> i ve got a working xenomai application using alchemy tasks and try to
> outource funtionallity into a shared object.
> If i try to create a thread (same code like in the application) in the
> shared object rt_create_task allways returns EEXISTS.
> Name parameter change or set to NULL does not change anything.
> 
> Are there any side effects if i try to create alchemy tasks inside a
> shared object or are there any restrictions?
> 

Short answer, no. However, I can't comment more on this issue, since I
don't know which -rc you are currently running, whether this is a dual
kernel or single kernel configuration, etc.

The output of the following command may help:

$ ./your-app --dump-config

-- 
Philippe.

