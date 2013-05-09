MIME-Version: 1.0
In-Reply-To: <CAPpP=rMLPeRAVCpdKQkLVD29pFUj8zPL5JRmTbrJkKEetJJbew@mail.gmail.com>
References: <CAPpP=rOMJi4u7sm9+a79aJ2GhhtJY7B5QD0+tVxsN7KoFMqxCw@mail.gmail.com>
	<518A5F0C.50403@xenomai.org>
	<CAPpP=rNt32NFsF5LhJybpcBRfm33za8kP2tQj+t4Vs9-hkH48w@mail.gmail.com>
	<518ABA3D.5070106@xenomai.org>
	<CAPpP=rOQm+GBuoB5KuAiAo5nG=HzggXb7CyLaP-SHAwebykPUw@mail.gmail.com>
	<518B8C50.2050107@xenomai.org>
	<CAPpP=rNkQTDCfRAxpN5wPNK-5R-4gngpxFGUCiqT2T8gwMKJRg@mail.gmail.com>
	<518BA407.8020103@xenomai.org>
	<CAPpP=rNCxHUfcBS7djmv8i+Er2PpXBdO101LfcxaZswzc9eBnw@mail.gmail.com>
	<518BAF44.9060803@xenomai.org>
	<CAPpP=rMLPeRAVCpdKQkLVD29pFUj8zPL5JRmTbrJkKEetJJbew@mail.gmail.com>
Date: Thu, 9 May 2013 16:51:34 +0200
Message-ID: <CAPpP=rM6BTevvfoV+TT4ej6zkeyzdnY7yN_qVCUPkLFe38EUYA@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [Posix] I/O multiplexing with select
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Sorry for the last mail..

Here is what I've done.

void *thread2(void *cookie)
{
        /* ... */
}

Task create_thread(pthread_t* t, const char* name, void *(*)(void *) funct,
void* arg)
{
        /* ... */
        pthread_create(t, ..., funct, arg);
        /* ... */

        pthread_set_name_np(t, name);
        /* ... */
}

int *thread(void *cookie)
{
    pthread_t tid1;
    pthread_t tid2;

    create_thread(&tid1, "name1", thread2, NULL);
    create_thread(&tid2, "name2", thread2, NULL);

    /* ... */

    pthread_cancel(&tid1);
    pthread_cancel(&tid2);

     /* ... */
}
