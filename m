MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17529.61757.805563.241802@domain.hid>
Date: Sun, 28 May 2006 20:51:41 +0200
Subject: Re: [Xenomai-help] Best way to identify a Xenomai task
In-Reply-To: <4479EA8E.5090607@domain.hid>
References: <44781751.30705@domain.hid>
	<17528.17846.771613.406263@domain.hid>
	<4479EA8E.5090607@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jean-Olivier Villemure <jean-olivier.villemure@domain.hid>
Cc: xenomai@xenomai.org

Jean-Olivier Villemure wrote:
 > Gilles Chanteperdrix wrote:
 > > The task Id of a new task is also returned by the task creation
 > > services:
 > > - rt_task_create for the native skin
 > >   
 > Thank you for your answer!
 > 
 > Looking at the API, i see that rt_task_create returns:
 > - 0 is returned upon success. Otherwise:
 > - ENOMEM is returned if the system fails to get enough dynamic memory 
 > from the global real-time heap in order to create or register the task.
 > - EEXIST is returned if the /name/ is already in use by some registered 
 > object.
 > - EPERM is returned if this service was called from an asynchronous context.
 > 
 > So according to this, no TaskId is returned by this function since 0 is 
 > returned upon success. But according to the EEXIST error, can we 
 > considerate that the name of the task is unique? So I could simply use 
 > this information to identify my tasks ?

Sorry, the task Id is not really returned by rt_task_create, the task Id
is the RT_TASK pointer passed as first argument.

-- 


					    Gilles Chanteperdrix.

