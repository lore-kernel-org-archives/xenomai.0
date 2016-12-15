From: Julien Stephan <julien.stephan@smile.fr>
Message-ID: <3aafa6c7-d201-bc14-d32c-48480e56bf2a@smile.fr>
Date: Thu, 15 Dec 2016 10:59:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] __map_umm return NULL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hello,

As explained in my previous question "TIP_HEAD bit during Xenomai
initialization" I am porting xenomai 3 on a new architecture.


My problem here is that the function __map_umm return NULL. This cause a
SEGV in cobalt_commit_memory.

I step into __map_umm with gdb and noticed that there is an open on
/dev/rtdm/memdev-private which return fd = 0 : I think this is not
normal ....

Then there is the ioctl command, which does not return an error and
finally, the mmap function that return NULL. I am pretty sure that this
is not normal too.

So what could be the cause?


Julien

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
