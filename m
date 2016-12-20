From: Julien Stephan <julien.stephan@smile.fr>
Message-ID: <a9bb92d8-5e99-7afe-4381-7fad371632d0@smile.fr>
Date: Tue, 20 Dec 2016 11:12:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] __COBALT_SYSCALL_BIT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

Is it safe to change __COBALT_SYSCALL_BIT from 0x10000000 to 0x700 ?
Or it may broke some xenomai functionnalities?

I need to do that, because the ISA of my architecture specifies that the
scall number should be on 12 bits... It is not compiling otherwise..

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
