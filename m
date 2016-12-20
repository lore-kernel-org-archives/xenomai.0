References: <a9bb92d8-5e99-7afe-4381-7fad371632d0@smile.fr>
 <21e6332e-1acf-d53e-3ad5-543ff548a3a5@xenomai.org>
From: Julien Stephan <julien.stephan@smile.fr>
Message-ID: <f0e3a9e8-4120-5076-e812-550d7ff4007f@smile.fr>
Date: Tue, 20 Dec 2016 13:36:44 +0100
MIME-Version: 1.0
In-Reply-To: <21e6332e-1acf-d53e-3ad5-543ff548a3a5@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] __COBALT_SYSCALL_BIT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

I'm porting Xenomai on the MPPA processor of Kalray. The problem is that
their Linux port is quite new and is not yet publicly available ...


On 20/12/2016 12:23, Philippe Gerum wrote:
> On 12/20/2016 11:12 AM, Julien Stephan wrote:
>> Hello,
>>
>> Is it safe to change __COBALT_SYSCALL_BIT from 0x10000000 to 0x700 ?
>> Or it may broke some xenomai functionnalities?
>>
>> I need to do that, because the ISA of my architecture specifies that the
>> scall number should be on 12 bits... It is not compiling otherwise..
>>
> I still don't know which architecture you are talking about, so I can't
> answer questions about porting Xenomai to it.
>

-- 
 
Logo <http://www.smile.fr/>

14 rue Génissieu
38000 GRENOBLE
www.smile.fr <http://www.smile.fr/> 	
*Julien STEPHAN*
Ingénieur étude et développement
Email : julien.stephan@smile.fr <mailto:julien.stephan@smile.fr>
Tel : +33 (0)4.58.00.19.59

 

bandeaux_mail
<http://www.smile.fr/Ressources/Livres-blancs/Ingenierie/Linux-pour-l-embarque?utm_source=signature&utm_medium=email&utm_campaign=signature>

eco Pour la planète, n'imprimez ce mail que si c'est nécessaire
