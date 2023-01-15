.data
// long
	ok: .long 1
	i: .long 0
	j: .long 0
	
// asciz
	nul: .asciz "\n"
	formatscanf: .asciz "%[^\n]"
	formatprintf: .asciz "%d "
	formatnegativ: .asciz "%d\n"
	formatnul: .asciz "%s"
	delim: .asciz " "
	
// input
	input: .space 500
	
// array
	v: .space 500
	poz: .space 500
	b: .space 500
	f: .space 500

// variables
	a: .space 4
	el: .space 4
	k: .space 4
	n: .space 4
	n3: .space 4
	m: .space 4
	pozitie: .space 4
	frecventa: .space 4
	x: .space 4

.text
verif:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	pushl %edi
	
	movl 8(%ebp), %ebx
	cmp $0, %ebx
	je cont

pregparametrii:
	movl 8(%ebp), %eax
	movl %eax, a
	subl m, %eax
	
forst:
	movl a, %ebx
	cmp %ebx, %eax
	jg dreapta
	
	cmp $0, %ebx
	jl dreapta
	
	movl (%edi, %ebx, 4), %edx
	cmp %edx, 12(%ebp)
	je rau
	
	jmp decrementarea		
	
dreapta:
	movl 8(%ebp), %eax
	movl %eax, a
	addl m, %eax	
	
fordr:
	movl a, %ebx
	cmp %ebx, %eax
	jl cont
	
	cmp n3, %ebx
	je cont
	
	movl (%edi, %ebx, 4), %edx
	cmp %edx, 12(%ebp)
	je rau
	
	jmp incrementarea
	
cont:
	movl 8(%ebp), %ebx
	movl 12(%ebp), %edx 
	movl %edx, (%edi, %ebx, 4)
	
	movl 12(%ebp), %ebx
	
	pushl %esi
	
	lea f, %esi
	movl (%esi, %ebx, 4), %edx
	incl %edx
	movl %edx, (%esi, %ebx, 4)
	
	popl %esi
	
	jmp bun
	
incrementarea:
	movl a, %ebx
	incl %ebx
	movl %ebx, a
	jmp fordr
	
decrementarea:
	movl a, %ebx
	decl %ebx
	movl %ebx, a
	jmp forst
	
rau: 
	
	xorl %eax, %eax
	jmp retverif
	
bun:
	movl $1, %eax	
	
retverif:
	popl %edi
	popl %esi
	popl %ebx
	popl %ebp
	ret	

//BACKTRACKING
bkt:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	pushl %edi
	
// Assign to x the value of the position in the vector for which we generate an element
	movl 8(%ebp), %edx
	movl %edx, x
	
// We initialize the counter for 'for' 
	movl $1, %ebx
	movl %ebx, k
	
forpermutare:
// If we have reached n, the for ends
	movl k, %ecx
	cmp n, %ecx
	jg returnarerea
	
// If ok is 0, it means that we have found a correct permutation
	movl ok, %ebx
	cmp $0, %ebx
	je returnarerea

// We save the position in the vector where we have to load the found value	
	movl 8(%ebp), %ebx
	movl (%esi, %ebx, 4), %edx
	movl %edx, pozitie
	
	pushl %esi
	lea b, %esi

// We put the found value in the permutation vector
	movl k, %edx
	movl %edx, (%esi, %ebx, 4)
	
// We check if the number appeared less than 3 times in a row
	lea f, %esi
	movl k, %ebx
	movl (%esi, %ebx, 4), %edx
	movl %edx, frecventa
	movl frecventa, %ebx
	popl %esi
	cmp $3, %ebx
	je incrementarek
	
	
aici:
// We check the found element
	pushl k
	pushl pozitie
	call verif
	popl %ebx
	popl %ebx
	
	cmp $0, %eax
	je incrementarek

salut2:
// If we found j - 1 elements, it means that we have to display the permutation
	movl 8(%ebp), %ebx
	movl j, %edx
	decl %edx
	cmp %ebx, %edx
	je returnarebuna

// If not, we call the bkt function	
	pushl k
	incl %ebx
	pushl %ebx
	call bkt
	popl %ebx
	popl k

	lea v, %edi
	lea b, %esi
	
// When we return from bkt, we decrease the frequency of the element and 
// remove it from the vector, if we have NOT already found the permutation
	movl ok, %ebx
	cmp $1, %ebx
	je stergere
	jmp incrementarek
 	
stergere:
	pushl %esi
	lea f, %esi
	movl k, %ebx
	movl (%esi, %ebx, 4), %edx
	decl %edx
	movl %edx, (%esi, %ebx, 4)
	
	popl %esi
	movl 8(%ebp), %ebx
	movl (%esi, %ebx, 4), %edx
	movl %edx, pozitie
	movl pozitie, %ebx
	xorl %edx, %edx
	movl %edx, (%edi, %ebx, 4)
	
incrementarek:
	movl k, %ecx
	incl %ecx
	movl %ecx, k
	jmp forpermutare
	
returnarebuna:
	movl $0, %ebx
	movl %ebx, ok	
	
returnarerea:
	popl %edi
	popl %esi
	popl %ebx
	popl %ebp
	ret	
	
.global main
main:
// Read the string
	pushl $input
	pushl $formatscanf
	call scanf 
	popl %ebx
	popl %ebx
	
// We initialise n	
	pushl $delim
	pushl $input
	call strtok
	popl %ebx
	popl %ebx
	
	pushl %eax
	call atoi
	popl %ebx
	
	movl %eax, n

// We initialise m
	pushl $delim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	pushl %eax
	call atoi
	popl %ebx
	
	movl %eax, m

// We prepare the vector pos
	lea poz, %esi

// We prepare the vector v
	lea v, %edi
	movl $3, %eax
	xorl %edx, %edx
	mull n
	movl %eax, n3
	
// We read the vector elements
forv:
	movl i, %ecx
	cmp n3, %ecx
	je pasul1
	
	pushl $delim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	pushl %eax
	call atoi
	popl %ebx
	
	movl i, %ecx
	movl %eax, (%edi, %ecx, 4)

// We check if the read element is 0. If so, it means that I have memorize its position 
// for backtracking
	cmp $0, %eax
	je pozitii
	
continuare1:
	pushl %esi
	lea f, %esi
	
	movl (%esi, %eax, 4), %ebx
	incl %ebx
	movl %ebx, (%esi, %eax, 4)
	
	popl %esi
	jmp incrementare

// We memorize the position where element 0 appeared
pozitii:
	movl j, %ebx
	movl %ecx, (%esi, %ebx, 4)
	incl %ebx
	movl %ebx, j
	jmp continuare1 

// We increment the contor
incrementare:	
	incl %ecx
	movl %ecx, i
	jmp forv	
	
// We check if at least one 0 appeared
pasul1:
	movl j, %ebx
	cmp $0, %ebx
	je condamnat
	jmp pasul2

// We call the backtracking function	
pasul2:
	pushl $0
	call bkt
	popl %ebx

	lea v, %edi

salut:
// We check if a permutation could be generated, and if not, we jump to the 'condamnat' tah where we display -1	
	movl ok, %ebx
	cmp $1, %ebx
	je condamnat
	
	movl $0, %ecx
	movl %ecx, i
	jmp permutare
	
permutare:
	movl i, %ecx
	cmp n3, %ecx
	je newline
	
forb:
	movl (%edi, %ecx, 4), %eax
	
	pushl %eax
	pushl $formatprintf
	call printf
	popl %ebx
	popl %ebx
	
	movl i, %ecx
	incl %ecx
	movl %ecx, i
	jmp permutare	
	
newline:
	pushl $nul
	pushl $formatnul
	call printf
	popl %ebx
	popl %ebx
	
	jmp exit		
	
// We display -1 if a valid permutation can't be generated.
condamnat:
	pushl $-1
	pushl $formatnegativ
	call printf 
	popl %ebx
	popl %ebx
	jmp exit
	
exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80