Message-ID: <448937A5.7080701@domain.hid>
Date: Fri, 09 Jun 2006 10:56:05 +0200
From: Lionel Perrin <perrin@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] shm_open, ftruncate
References: <4480595D.7040203@domain.hid>	<17536.29324.723709.385494@domain.hid>	<4484365A.7090007@domain.hid>	<17540.21517.871383.751462@domain.hid>	<44856CA7.30802@domain.hid>	<17541.29542.312486.329018@domain.hid>	<44859C28.3090600@domain.hid>	<17541.49945.431732.834139@domain.hid>	<4486CCDF.2070409@domain.hid>
	<17542.59422.109900.142889@domain.hid>
In-Reply-To: <17542.59422.109900.142889@domain.hid>
Content-Type: multipart/mixed; boundary="------------020902090007020004060903"
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

This is a multi-part message in MIME format.
--------------020902090007020004060903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

 
>  > > I can confirm that a few fixes in v2.1 were missing, so trunk works
>  > > correctly, didn't you forget to rebuild the kernel when building trunk ?
>  > > Attached is a patch to v2.1 that contain the fixes backported from
>  > > trunk. Please try this patch and tell me if this works for you.
>  > >   
>  > In fact, I've downloaded the last version of trunk before your mail and 
>  > the patch. You're right that works pretty good with this version... :)
>  > 
>  > Unfortunately, it seem's that we can't share between a real time process 
>  > and a non real one ?
>
> Sharing memory should work, could you explain what happens ? Note that
> you may use Linux regular shared memory services in the real-time
> process by calling __real_shm_open instead of shm_open.
>   
Ok,
But I'd like a real time behaviour of shared memory for my real time 
task... so I can't use __real_shm_open, etc...

Here is the little code I've developped to access shared memory. May be 
there some mistakes...
I compile it with or without xeno-config --posix-cflags, xeno-config 
--posix-ldflags to get two executables.
I launch these two executables and the shared_memory seem's to be 
different in these two cases.
All Xenomai processes are accessing the same shared_memory while all 
non-xenomai processes are accessing another one shared memory.



--------------020902090007020004060903
Content-Type: text/plain;
 name="rtsharedmem.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtsharedmem.c"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <fcntl.h> 
#include <pthread.h>
#include <errno.h>

#include "rtsharedmem.h"

/* **********************************************************************
 *	Creates a shared memory object protected by a mutex		*
 *  This object is referenced throw its name. If there's no		*
 *  shared memory object with the given name, a new one is created,	*
 *  otherwise, we get an access to the existing shared memory object.	*
 ************************************************************************/
MemMap* RtOpenSharedMem(unsigned int nbvalues, const char * name) {
	int shm_exists;
	int h_shm;
	MemMap* mem;
	void * ptr;
	int * nbaccess;
	char *name_shm;
	name_shm = (char *)malloc((strlen(name)+6)*sizeof(char));
	mem = (MemMap *)malloc(sizeof(MemMap));
	shm_exists = 0;
	strcpy(name_shm, name);
	sprintf(name_shm, "/%s_shm", name);
	
	
	/* Here is the clean version to open shm, but for the moment, this doesn't work with xenomai.*/
	
	h_shm = shm_open( name_shm, O_RDWR | O_CREAT | O_EXCL, S_IRUSR | S_IWUSR | S_IROTH | S_IWOTH);
	if (h_shm < 0)
	{
		if (errno == EEXIST)
		{
			/* shm_open has just warned that shm already exists */
			/* we shouldn't need O_CREAT here but xenomain failed without */
			h_shm = shm_open( name_shm, O_RDWR|  O_CREAT, S_IRUSR | S_IWUSR | S_IROTH | S_IWOTH);
			if (h_shm<0)
			{
				printf("shm_open failed to open existing shared mem : %s\n", name_shm);
				return NULL;
			}
			shm_exists = 1;
		}
		else
		{
			/* shm_open really failed */
			printf("shm_open failed to open %s\n", name_shm);
			return NULL;
		}
	}
	
// 	/* the following lines shouldn't be commented but xenomai... */
// 	else
// 	{
// 		/* a new shm_file has been created, we need to truncate it */
// 		if (ftruncate(h_shm, nbvalues * sizeof(double))==-1)
// 		{
// 			printf("truncate failed\n");
// 			goto close_and_unlink;
// 		}
// 	}
	
	if (ftruncate(h_shm, nbvalues * sizeof(double))==-1)
	{
		printf("truncate failed\n");
		goto close_and_unlink;
	}
	
	ptr = mmap(NULL, sizeof(int) + nbvalues * sizeof(double), PROT_READ | PROT_WRITE, MAP_SHARED, h_shm, 0);
	if( ptr == MAP_FAILED) {
		printf("mmap failed\n");
		goto close_and_unlink;
	}
	
	mem->h_mut = (pthread_mutex_t *)malloc(sizeof(pthread_mutex_t));
	pthread_mutex_init(mem->h_mut, NULL);

	/* the first sizeof(int) bytes at ptr are reserved to count the number of access to shared mem
	in order to be able to unlink cleanly */
	nbaccess = (int *)ptr;
	if (shm_exists)
		*nbaccess = (*nbaccess)+1;
	else
		*nbaccess = 1;
	/* the real data starts at ptr + sizeof(int) */
	mem->ptr = (double *)(ptr + sizeof(int));
	mem->h_shm = h_shm;
	mem->nbvalues = nbvalues;
	mem->name_shm = name_shm;
	return mem;
	
close_and_unlink:
	close(h_shm);
	if (shm_exists==0)
		shm_unlink(name_shm);
	free(name_shm);
	free(mem);
	return NULL;
}

/****************************************************************
 *	Write datas to the shared memory after getting the mutex*
 ****************************************************************/
int RtWriteSharedMem(MemMap * shared_mem, const double * data) {
	if(pthread_mutex_lock(shared_mem->h_mut)!=0)
		return -1;
	memcpy(shared_mem->ptr, data, shared_mem->nbvalues * (sizeof(double)) );
	if (pthread_mutex_unlock(shared_mem->h_mut)!=0)
		return -1;
	return 0;
}

/****************************************************************
 *	Read datas from the shared memory and copy it to data	*
 ****************************************************************/
int RtReadSharedMem(double * data, const MemMap * shared_mem) {
	if(pthread_mutex_lock(shared_mem->h_mut)!=0)
		return -1;
	memcpy(data, shared_mem->ptr, shared_mem->nbvalues * (sizeof(double)) );
	if (pthread_mutex_unlock(shared_mem->h_mut)!=0)
		return -1;
	return 0;
}

/****************************************************************
 *	Close shared memory : no further access can't be done.	*
 *  Memory allocated in RtOpenSharedMem is freed.		*
 ****************************************************************/
int RtCloseSharedMem(MemMap * shared_mem) {
	void *ptr;
	int *ptr_nbaccess;
	int int_nbaccess;
	if (shared_mem == NULL)
		return -1;
	
	if (pthread_mutex_lock(shared_mem->h_mut)!=0)
		return -1;
	
	/* the sizeof(int) bytes before shared_mem->ptr count the number of access to shared memory */
	ptr = shared_mem->ptr - sizeof(int);
	ptr_nbaccess = (int *)ptr;
	*ptr_nbaccess = *ptr_nbaccess - 1;
	int_nbaccess = *ptr_nbaccess;
	// printf("number of access %d\n", int_nbaccess);
	
	if (munmap(ptr, sizeof(int) + shared_mem->nbvalues * sizeof(double))!=0)
		return -1;

	if (close(shared_mem->h_shm)!=0)
		return -1;	

	if (pthread_mutex_unlock(shared_mem->h_mut)!=0)
		return -1;
	if (pthread_mutex_destroy(shared_mem->h_mut)!=0)
		return -1;
	
	if (int_nbaccess == 0) /* that was the last process to access this shared mem */
		shm_unlink(shared_mem->name_shm);
	free(shared_mem->name_shm);
	free(shared_mem);
	shared_mem = NULL;
	return 0;	
}

--------------020902090007020004060903
Content-Type: text/plain;
 name="rtsharedmem.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtsharedmem.h"

#ifndef __RTSHAREDMEM_H__
#define __RTSHAREDMEM_H__

#include <pthread.h>

typedef struct {
	void *ptr;
	int h_shm;
	pthread_mutex_t *h_mut;
	char * name_shm;
	char * name_mut;
	unsigned int nbvalues;
} MemMap;



MemMap* RtOpenSharedMem(unsigned int nbvalues, const char * name);
int RtWriteSharedMem(MemMap * shared_mem, const double * data);
int RtReadSharedMem(double * data, const MemMap * shared_mem);
int RtCloseSharedMem(MemMap * shared_mem);


#endif // __RTSHAREDMEM_H__

--------------020902090007020004060903
Content-Type: text/plain;
 name="test_rtsharedmem.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_rtsharedmem.c"

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#include <sys/mman.h>

#include "rttimer.h"
#include "rtsharedmem.h"

#define NANOCOEF 0.000000001

int RtSetAsPriorityTask()
{
	struct sched_param mysched;
	mlockall(MCL_CURRENT | MCL_FUTURE);
	mysched.sched_priority = sched_get_priority_max(SCHED_FIFO) - 1;
	pthread_setschedparam( pthread_self(), SCHED_FIFO, &mysched);
	return 0;
}

void RtWaitFor(double time) {
	struct timespec rqtp, rmtp;
	rqtp.tv_sec = (time_t)time;
	rqtp.tv_nsec = (long) ( ( time - (double)(rqtp.tv_sec) ) / NANOCOEF );
	nanosleep(&rqtp, &rmtp);
}


int main(int argc, char * argv[])
{
	MemMap *mem;
	double *data, *val;
	
	RtSetAsPriorityTask();
	data = (double *)calloc(1, sizeof(double));
	val = (double *)malloc(sizeof(double));
	
	
	if (argc==1)
		*val = 1.0;
	else
		*val = atof(argv[1]);

	//printf("EACCES %d, EFAULT %d, EFBIG %d, EINTR %d, EINVAL %d, EIO %d, EISDIR %d, ELOOP %d, ENAMETOOLONG %d, ENOENT %d, ENOTDIR %d, EROFS %d, ETXTBSY %d, EBADF %d\n", EACCES, EFAULT, EFBIG, EINTR, EINVAL, EIO, EISDIR, ELOOP, ENAMETOOLONG, ENOENT, ENOTDIR, EROFS, ETXTBSY, EBADF);


	mem = RtOpenSharedMem(1, "shared1");
	if (mem == NULL)
	{
		printf("ERRNO %d\n", errno);
		perror("RtOpenSharedMem");
		return -1;
	}
	printf("data written\t%lf\n", ((double *)(val))[0]);
	fflush(stdout);
	if (RtWriteSharedMem(mem, (double *)val)<0)
	{
		perror("RtWriteSharedMem");
		return -1;
	}
	RtWaitFor(1.0);
	if (RtReadSharedMem(data, mem)<0)
	{
		perror("RtReadSharedMem");
		return -1;
	}
	printf("data read\t%lf\n", data[0]);
	fflush(stdout);
	if (RtCloseSharedMem(mem)<0)
	{
		perror("RtCloseSharedMem");
		return -1;
	}
	return 0;
}

--------------020902090007020004060903--

