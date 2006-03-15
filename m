Message-ID: <44184158.8010805@domain.hid>
Date: Wed, 15 Mar 2006 10:31:20 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] the same error-solution
References: <4416CC6A.8030605@domain.hid>	<17430.53111.874553.840320@domain.hid>	<4416D650.3040609@domain.hid>	<17430.59156.719375.430724@domain.hid>
	<4417C3D8.10801@domain.hid>
In-Reply-To: <4417C3D8.10801@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

marcellin wrote:
> -I've forgot rt_task_shadow() in the main Linux thread

It would be helpful to add a note to the API docs for rt_task_shadow() explaining this usage.  It would also be good to note that tasks created in this way must also be cleaned up using rt_task_delete().

rt_task_shadow()
-----
Turns the current Linux task into a native Xenomai task.  Creates a real-time task running in the context of the calling regular Linux task in user-space.  For instance, calling rt_task_shadow() from main() will map the program's main thread to a native Xenomai thread, allowing it to invoke blocking real-time services.  Note that all tasks created using rt_task_shadow() must be cleaned up using rt_task_delete().
-----

It would be good to put a note in the rt_task_delete() docs as well.

rt_task_delete()
-----
... A task exists in the system since rt_task_create() ( or possibly rt_task_shadow() ) has been called to create it, so this service must be called in order to destroy it afterwards...
-----

I'm sure these comments are obvious to many folks, but it would help out the newbies.  It is helpful when the documentation explicitly says things like this, so one doesn't have to guess.

Thanks again for putting in the effort to make great API documentation.  I believe it is essential to the widespread adoption of Xenomai, and makes it very attractive to the newcomer.

If you would rather have me submit suggestions like this in patch form, I would be happy to do so.  Just show me an example diff (or 'svn diff'?)  command so I know what command-line options you prefer.

-Jeff

