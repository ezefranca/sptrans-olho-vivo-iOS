//
//  ViewController.m
//  teste-sptrans
//
//  Created by Ezequiel Franca dos Santos on 12/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "APIOlhoVivo.h"

@interface APIOlhoVivo ()

@end

@implementation APIOlhoVivo

@synthesize token;


- (id)initWithToken:(NSString *)seuToken
{
    self = [super init];
    if (self) {
        token = seuToken;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //PEGUE SEU TOKEN NO SITE DA SPTRANS
    
    //http://www.sptrans.com.br/desenvolvedores
    token = @"67542d68a9ba2751de039bd09dd42473e1d6e51cbdc49ebfec2bc4d52fc32102";

    
/* Autenticação e credenciais
    Para autenticar-se no serviço de API do Olho Vivo é necessário efetuar uma chamada prévia utilizando o método http POST informando seu token de acesso. Essa chamada irá retornar true quando a autenticação for realizada com sucesso e false em caso de erros.

    Veja um exemplo:
    
    POST /Login/Autenticar?token={token}
    
    RETURN
    true

*/
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.olhovivo.sptrans.com.br/v0/Login/Autenticar?token=%@", token]]];
    
    //Tem que ser POST
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    //E la vai nossa conexao!
    
    NSURLConnection *conexao = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    //Vamos ver se a conexao deu certo!
        
        if(conexao)
        {
            NSLog(@"Opa, deu certo sua conexao mano!");      }
        else
        {
            NSLog(@"Cara sua conexao deu erro!");
        }
    
    //Estes tres metodos abaixos sao do delegate NSURLConnetion
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data{
    NSString* myString;
    myString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"RECEBEU: %@", myString);
   
    // Se liga, se deu certo a autenticao ...
    if ([myString isEqualToString:@"true"]) {
    // ... Eu entrei aqui
        
        // Beleza, as consultas sao feitas atraves de GET
        

        
        NSURL *url = [NSURL URLWithString:@"http://api.olhovivo.sptrans.com.br/v0/Parada/Buscar?termosBusca=AFONSO"];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setHTTPMethod:@"GET"];
        [request setURL:url];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *responseCode = nil;
        
        // Esse cara aqui que vai estar com nosso binario do JSON que depois sera Serializado.
        NSData *ResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
       
        
        if([responseCode statusCode] != 200){
            NSLog(@"Erro no link %@, HTTP status code %i", url, [responseCode statusCode]);
            return;
        }
        else{
            NSLog(@"Tudo Certo!!, go go gerar o JSON");
            NSError *error;
            NSMutableDictionary *jsonDadosUsuario = [NSJSONSerialization
                                                     JSONObjectWithData:ResponseData
                                                     options:NSJSONReadingMutableContainers
                                                     error:&error];
            
            NSLog(@"%@", jsonDadosUsuario);
            
            // Aqui comeca a parsear a parada
        }
    }
}

//Metodos abaixo sao de delegate
    
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    NSLog(@"ERRO: %@", error);
    //This method , you can use to receive the error report in case of connection is not made to server.
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSLog(@"CONECTOU");
 //   The above method is used to process the data after connection has made successfully.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
