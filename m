Message-ID: <50504805.7040509@xenomai.org>
Date: Wed, 12 Sep 2012 10:29:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF88348236.1046CAF7-ONC1257A77.002D5DEF-C1257A77.002DB549@LocalDomain>
In-Reply-To: <OF88348236.1046CAF7-ONC1257A77.002D5DEF-C1257A77.002DB549@LocalDomain>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] posix skin pthread_create issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre.QUELIN@solystic.com
Cc: xenomai@xenomai.org

On 09/12/2012 10:19 AM, Pierre.QUELIN@solystic.com wrote:
> 
> Dear all,
> 
> I have an application that is working fine with the standard Linux
> kernel API and don't works if I build it with Xenomai API.

What version of Xenomai? What I-pipe patch? What platform?

> 
> I have a strange issue. At the begining, the application creates 28
> threads and all the 33 next returns an error. pthread_create()
> returns 12 (ENOMEM).
> 
> I'm not sure to understand which memory is missing.
> 
> To solve this I have try :
> 
> 1) to fix the pthread stack size at PTHREAD_STACK_MIN. =>without
> effect

For the stack size issue, see:
http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_my_application_reserves_a_lot_of_memory

But that is probably not your issue.

> 2) to change the RealTime sub-system options I increase the number of
> registry slots from 512 to 1024 I increase the size of the system
> heap from 256 to 1024 I increase the size of the private stack pool
> from 128 to 512 =>without effect
> 
> Could you please help me.

ENOMEM seems to be returned in case the stack pool is not large enough.
Maybe 512 is not enough? If using Xenomai 2.6.0 with gcc 4.7, you should
add '-fno-omit-frame-pointer' to the CFLAGS. This issue is fixed in
Xenomai 2.6.1.

> 
> Best regards
> 
> Pierre Quelin Ce message et toutes les pièces jointes (ci-après le
> "Message") sont confidentiels et établis à l'intention exclusive de
> leurs destinataires. Si vous avez reçu le Message par erreur, merci
> de l'indiquer à son expéditeur par retour et de procéder à sa
> destruction dans vos systèmes.Toute utilisation ou diffusion de son
> contenu non autorisée est strictement interdite. Tout message
> électronique est susceptible d'altération. SOLYSTIC décline toute
> responsabilité au titre du Message s'il a été altéré, déformé ou
> falsifié. SOLYSTIC ne saurait être tenue pour responsable, ni de la
> transmission erronée ou incomplète des informations contenues dans ce
> message, ni des délais de réception ou des dommages causés à votre
> système. SOLYSTIC ne garantit, ni que l'intégrité de la communication
> ait été maintenue, ni que cette transmission est exempte de virus,
> d'interceptions ou d'interférences.
> 
> This message and any attachments (the "Message") are confidential and
> intended solely for the addressee(s). Any unauthorised use or
> dissemination of the Message is strictly prohibited. E-mails are
> susceptible to alteration. SOLYSTIC shall not be liable for the
> Message if altered, changed or falsified. SOLYSTIC shall not be
> liable for the improper or incomplete transmission of the information
> contained in the Message nor for any delay in its receipt or damage
> to your system. SOLYSTIC does neither guarantee that the integrity of
> the Message has been maintained, nor that this communication is free
> of viruses, interceptions or interferences.

As usual, please send us messages without this notice: the only way for
us to comply with this notice is to unsubscribe you from the mailing
list. The mailing list is public, its archives are on the web for all to
see, so we are actively disseminating your message.

-- 
					    Gilles.

